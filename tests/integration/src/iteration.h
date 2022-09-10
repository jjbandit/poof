#include <tests/integration/src/common_structures.h>

#if 1
poof(
  func (foo_enum Type)
  {
    Type.map_values (Value) {
      (Value.name) (Value.value)
    }
  }
)
#include <tests/integration/generated/anonymous_function_foo_1.h>

poof(
  func (foo_struct_0 Type)
  {
    Type.map_members (Value)
    {
      (Value.type) (Value.name) (Value.value)
    }
  }
)
#include <tests/integration/generated/anonymous_function_foo_2.h>
#endif

poof(d_union foobar_dunion { foo_struct_0 bar_struct } )
#include <tests/integration/generated/d_union_foobar_union.h>

poof(
  func (foobar_dunion Foobar)
  {
    -- all members start --

    Foobar.map_members (Member)
    {
      (Member.type) (Member.name) (Member.value)
    }

    -- all members end --

    -- filtered members start --

    Foobar.map_members(M)
    {
      M.is_union?
      {
        M.map_members(UM).containing(nested_struct)
        {
          (UM.type) (UM.name)
        }
      }
    }

    -- filtered members end --

  }
)
#include <tests/integration/generated/anonymous_function_foo_3.h>

