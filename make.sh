#! /bin/bash

# set -o nounset
# set -o pipefail
# set -o errexit

# NOTE(Jesse): The following are switches for twiddling during development.
# Calling functions by name on the command line shouldn't be affected by these.

# git checkout $META_OUT

TEST_LOG_LEVEL="--log-level LogLevel_Error"
# TEST_LOG_LEVEL="--log-level LogLevel_Debug"

# POOF_LOG_LEVEL="--log-level LogLevel_Shush"
POOF_LOG_LEVEL="--log-level LogLevel_Error"
POOF_LOG_LEVEL="--log-level LogLevel_Debug"

INTEGRATION_TEST_LOG_LEVEL="--log-level LogLevel_Error"
# INTEGRATION_TEST_LOG_LEVEL="--log-level LogLevel_Debug"

BUILD_EVERYTHING=0

RunPreemptivePoof=1

# RunPoof=1
# BuildPoof=1
# POOF_DEBUGGER="gdb --args"

# RunParserTests=1
# BuildParserTests=1
# TEST_DEBUGGER="gdb --args"

# BuildAndRunAllExamples=1

# RunIntegrationTests=1
# INTEGRATION_TEST_DEBUGGER="gdb --args"

# OPTIMIZATION_LEVEL="-O2"






. scripts/preamble.sh
. scripts/setup_for_cxx.sh

if [ $# -gt 1 ]; then
  echo "make.sh supports a maximum of 1 argument"
fi

ROOT="."
SRC="$ROOT/poof"
BIN="$ROOT/bin"
BIN_TEST="$BIN/tests"
META_OUT="$ROOT/poof/generated"


function RunPoof {
  ColorizeTitle "Poofing!"

  # NOTE(Jesse): This currently doesn't work (well, it could be forced to)
  # because poof/generated/generate_cursor_c_token.h isn't generated and I don't
  # really want to move it out of there since a med-term goal is to be able to
  # augment generated structures with additional members
  #
  # If you really want, add:
  #
  # git checkout poof/generated/generate_cursor_c_token.h
  #
  # to special-case that one file.
  #

  if [ -d $META_OUT ]; then
    rm -Rf $META_OUT
    git checkout poof/generated/generate_cursor_c_token.h
    git checkout poof/generated/for_all_datatypes_debug_print_functions.h
    git checkout poof/generated/for_all_datatypes_debug_print_prototypes.h
  fi

  : "${POOF_EXECUTABLE:=./bin/poof}"

  $POOF_DEBUGGER $POOF_EXECUTABLE \
                                  \
    $POOF_LOG_LEVEL               \
    poof/poof.cpp                 \
    $COLORFLAG                    \
    -D BONSAI_PREPROCESSOR        \
    -D BONSAI_LINUX               \
    -I "."                        \
    -I "include"                  \
    -o $META_OUT

  if [ $? -eq 0 ]; then
    echo -e "$Success Poofed"
  else
    echo -e "$Failed Poofing"
  fi

  echo -e ""
  echo -e "$Delimeter"
  echo -e ""

}

function BuildPoof {

  : "${OPTIMIZATION_LEVEL:="-O0"}"

  which clang++ > /dev/null
  [ $? -ne 0 ] && echo -e "Please install clang++" && exit 1

  ColorizeTitle "Building Poof"
  source_file="$SRC/poof.cpp"
  SetFullOutputName "$source_file" bin
  echo -e "$Building $source_file"

  clang++                        \
    $source_file                 \
    $OPTIMIZATION_LEVEL          \
    $CXX_OPTIONS                 \
    $PLATFORM_CXX_OPTIONS        \
    $PLATFORM_LINKER_OPTIONS     \
    $PLATFORM_DEFINES            \
    -D "BONSAI_DEBUG_SYSTEM_API" \
    $PLATFORM_INCLUDE_DIRS       \
    -I "$ROOT"                   \
    -I "$ROOT/include"           \
    -o "$full_output_name"

  if [ $? -eq 0 ]; then
    echo -e "$Success $source_file -> $full_output_name"

    echo -e ""
    echo -e "$Delimeter"
    echo -e ""

  else
   echo ""
   echo -e "$Failed Error building poof, exiting."
   exit 1
  fi
}

function RunIntegrationTests()
{
  ColorizeTitle "Running Integration Tests"

  INTEGRATION_SRC_DIR=tests/integration/src
  INTEGRATION_OUTPUT_DIR=tests/integration/generated

  FILES_TO_POOF=$(find $INTEGRATION_SRC_DIR -type f | grep '\.h')

  for filename in $FILES_TO_POOF; do

    basename_stripped=$(basename $filename .h)

    # Each test file has a directory created under the output directory that
    # we'll write all the meta() output to for that test file.  We diff that
    # whole directory to confirm/deny the output is identical for that test file

    $INTEGRATION_TEST_DEBUGGER bin/poof \
      $INTEGRATION_TEST_LOG_LEVEL       \
      $filename                         \
      $COLORFLAG                        \
      -o $INTEGRATION_OUTPUT_DIR/$basename_stripped

    DIFF_CHANGED=$(git diff --ignore-all-space --ignore-blank-lines $INTEGRATION_OUTPUT_DIR/$basename_stripped | wc -l)

    if [[ $DIFF_CHANGED == 0 ]]; then
      echo -e "$Success $filename"
      echo -e ""
    else
      echo -e "$Failed $filename"
      echo -e ""
    fi
  done

  echo -e ""
  echo -e "$Delimeter"
  echo -e ""
}

function BuildParserTests
{
  ColorizeTitle "Building Tests"
    source_file=tests/parser/poof.cpp
    SetFullOutputName "$source_file" bin/tests
    echo -e "$Building $source_file"

    clang++                    \
      $source_file             \
      $OPTIMIZATION_LEVEL      \
      $CXX_OPTIONS             \
      $PLATFORM_CXX_OPTIONS    \
      $PLATFORM_LINKER_OPTIONS \
      $PLATFORM_DEFINES        \
      $PLATFORM_INCLUDE_DIRS   \
      -I"."                    \
      -I"include"              \
      -o "$full_output_name"

  if [ $? -eq 0 ]; then
    echo -e "$Success $source_file -> $full_output_name"
    echo -e ""
    echo -e "$Delimeter"
    echo -e ""

  else
   echo ""
   echo -e "$Failed Error building $source_file, exiting."
   echo ""
   exit 1
  fi

}

function RunParserTests
{
  ColorizeTitle "Running Parser Tests"
  $TEST_DEBUGGER ./bin/tests/poof $COLORFLAG \
    $TEST_LOG_LEVEL \
    $COLORFLAG

  echo -e "$Delimeter"
  echo -e ""
}


function BuildAll
{
  BuildPoof
  BuildParserTests
}

function RunAllTests
{
  RunParserTests
  RunIntegrationTests
}

function BuildAndRunAll
{
  BuildAll
  RunAllTests
  BuildAndRunAllExamples
}

function BuildAndRunAllExamples
{
  pushd examples
  ./make_all_examples.sh
  # ./run_all_examples.sh
  popd
}


if [ ! -d "$BIN" ]; then
  mkdir "$BIN"
fi

if [ ! -d "$BIN_TEST" ]; then
  mkdir "$BIN_TEST"
fi

echo -e ""
echo -e "$Delimeter"
echo -e ""

# If someone supplied a command line argument, call the function, otherwise
# respect the runflags
if [ $# -eq 1 ]; then

  # If someone's just trying to run the build/tests from the CLI normally don't
  # throw a bunch of garbage output
  TEST_LOG_LEVEL="--log-level LogLevel_Error"
  POOF_LOG_LEVEL="--log-level LogLevel_Error"

  # If someone's just trying to run the build/tests from the CLI normally don't
  # throw them into a debugging environment
  POOF_DEBUGGER=""
  TEST_DEBUGGER=""

  "$@"

else

  if [[ $RunPreemptivePoof == 1 || $BUILD_EVERYTHING == 1 ]]; then
    # TODO(Jesse): Cache and reset these?
    old_poof_executable=$POOF_EXECUTABLE
    POOF_EXECUTABLE=poof

    old_poof_debugger=$POOF_DEBUGGER
    POOF_DEBUGGER=

    old_poof_log_level=$POOF_LOG_LEVEL
    POOF_LOG_LEVEL="--log-level LogLevel_Error"

    RunPoof

    POOF_LOG_LEVEL=$old_poof_log_level
    POOF_DEBUGGER=$old_poof_debugger
    POOF_EXECUTABLE=$old_poof_executable
  fi

  if [[ $BuildPoof == 1 || $BUILD_EVERYTHING == 1 ]]; then
    BuildPoof
  fi

  if [[ $RunPoof == 1 || $BUILD_EVERYTHING == 1 ]]; then
    RunPoof
  fi

  if [[ $BuildParserTests == 1 || $BUILD_EVERYTHING == 1 ]]; then
    BuildParserTests
  fi

  if [[ $BuildAndRunAllExamples == 1 || $BUILD_EVERYTHING == 1 ]]; then
    BuildAndRunAllExamples
  fi



  if [[ $RunParserTests == 1 || $BUILD_EVERYTHING == 1 ]]; then
    RunParserTests
  fi

  if [[ $RunIntegrationTests == 1 ]]; then
    RunIntegrationTests
  fi

fi
