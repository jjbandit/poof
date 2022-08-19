        bonsai_function counted_string
    ToString( type_qualifier Type)
    {
      counted_string Result = {};
      switch (Type)
      {
                    case TypeQual_None: { Result = CSz("TypeQual_None"); } break;
            case TypeQual_ThreadLocal: { Result = CSz("TypeQual_ThreadLocal"); } break;
            case TypeQual_Const: { Result = CSz("TypeQual_Const"); } break;
            case TypeQual_Static: { Result = CSz("TypeQual_Static"); } break;
            case TypeQual_Volatile: { Result = CSz("TypeQual_Volatile"); } break;
            case TypeQual_Unsigned: { Result = CSz("TypeQual_Unsigned"); } break;
            case TypeQual_Signed: { Result = CSz("TypeQual_Signed"); } break;
            case TypeQual_Int: { Result = CSz("TypeQual_Int"); } break;
            case TypeQual_Char: { Result = CSz("TypeQual_Char"); } break;
            case TypeQual_Long: { Result = CSz("TypeQual_Long"); } break;
            case TypeQual_LongLong: { Result = CSz("TypeQual_LongLong"); } break;
            case TypeQual_LongDouble: { Result = CSz("TypeQual_LongDouble"); } break;
            case TypeQual_Short: { Result = CSz("TypeQual_Short"); } break;
            case TypeQual_Struct: { Result = CSz("TypeQual_Struct"); } break;
            case TypeQual_Union: { Result = CSz("TypeQual_Union"); } break;
            case TypeQual_Enum: { Result = CSz("TypeQual_Enum"); } break;
            case TypeQual_Inline: { Result = CSz("TypeQual_Inline"); } break;

      }
      return Result;
    }

        bonsai_function type_qualifier
    TypeQualifier(counted_string S)
    {
      type_qualifier Result = {};

                if (StringsMatch(S, CSz("TypeQual_None"))) { return TypeQual_None; }
          if (StringsMatch(S, CSz("TypeQual_ThreadLocal"))) { return TypeQual_ThreadLocal; }
          if (StringsMatch(S, CSz("TypeQual_Const"))) { return TypeQual_Const; }
          if (StringsMatch(S, CSz("TypeQual_Static"))) { return TypeQual_Static; }
          if (StringsMatch(S, CSz("TypeQual_Volatile"))) { return TypeQual_Volatile; }
          if (StringsMatch(S, CSz("TypeQual_Unsigned"))) { return TypeQual_Unsigned; }
          if (StringsMatch(S, CSz("TypeQual_Signed"))) { return TypeQual_Signed; }
          if (StringsMatch(S, CSz("TypeQual_Int"))) { return TypeQual_Int; }
          if (StringsMatch(S, CSz("TypeQual_Char"))) { return TypeQual_Char; }
          if (StringsMatch(S, CSz("TypeQual_Long"))) { return TypeQual_Long; }
          if (StringsMatch(S, CSz("TypeQual_LongLong"))) { return TypeQual_LongLong; }
          if (StringsMatch(S, CSz("TypeQual_LongDouble"))) { return TypeQual_LongDouble; }
          if (StringsMatch(S, CSz("TypeQual_Short"))) { return TypeQual_Short; }
          if (StringsMatch(S, CSz("TypeQual_Struct"))) { return TypeQual_Struct; }
          if (StringsMatch(S, CSz("TypeQual_Union"))) { return TypeQual_Union; }
          if (StringsMatch(S, CSz("TypeQual_Enum"))) { return TypeQual_Enum; }
          if (StringsMatch(S, CSz("TypeQual_Inline"))) { return TypeQual_Inline; }


      return Result;
    }


