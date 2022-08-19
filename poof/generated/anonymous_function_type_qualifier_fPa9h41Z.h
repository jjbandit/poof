                  if (Type->Qualifier & TypeQual_None)
          {
            Append(&Builder, CSz("none"));
          }
          if (Type->Qualifier & TypeQual_ThreadLocal)
          {
            Append(&Builder, CSz("threadlocal"));
          }
          if (Type->Qualifier & TypeQual_Const)
          {
            Append(&Builder, CSz("const"));
          }
          if (Type->Qualifier & TypeQual_Static)
          {
            Append(&Builder, CSz("static"));
          }
          if (Type->Qualifier & TypeQual_Volatile)
          {
            Append(&Builder, CSz("volatile"));
          }
          if (Type->Qualifier & TypeQual_Unsigned)
          {
            Append(&Builder, CSz("unsigned"));
          }
          if (Type->Qualifier & TypeQual_Signed)
          {
            Append(&Builder, CSz("signed"));
          }
          if (Type->Qualifier & TypeQual_Int)
          {
            Append(&Builder, CSz("int"));
          }
          if (Type->Qualifier & TypeQual_Char)
          {
            Append(&Builder, CSz("char"));
          }
          if (Type->Qualifier & TypeQual_Long)
          {
            Append(&Builder, CSz("long"));
          }
          if (Type->Qualifier & TypeQual_LongLong)
          {
            Append(&Builder, CSz("longlong"));
          }
          if (Type->Qualifier & TypeQual_LongDouble)
          {
            Append(&Builder, CSz("longdouble"));
          }
          if (Type->Qualifier & TypeQual_Short)
          {
            Append(&Builder, CSz("short"));
          }
          if (Type->Qualifier & TypeQual_Struct)
          {
            Append(&Builder, CSz("struct"));
          }
          if (Type->Qualifier & TypeQual_Union)
          {
            Append(&Builder, CSz("union"));
          }
          if (Type->Qualifier & TypeQual_Enum)
          {
            Append(&Builder, CSz("enum"));
          }
          if (Type->Qualifier & TypeQual_Inline)
          {
            Append(&Builder, CSz("inline"));
          }


