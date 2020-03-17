
    
      function counted_string
      ToString(metaprogramming_directive Type)
      {
        counted_string Result = {};
        switch (Type)
        {
          
            case meta_directive_noop: { Result = CS("meta_directive_noop"); } break;

            case generate_stream: { Result = CS("generate_stream"); } break;

            case generate_cursor: { Result = CS("generate_cursor"); } break;

            case generate_value_table: { Result = CS("generate_value_table"); } break;

            case for_enum_values: { Result = CS("for_enum_values"); } break;

            case for_members_in: { Result = CS("for_members_in"); } break;

            case d_union: { Result = CS("d_union"); } break;

            case enum_only: { Result = CS("enum_only"); } break;

            case member_is_or_contains_type: { Result = CS("member_is_or_contains_type"); } break;

            case for_all_datatypes: { Result = CS("for_all_datatypes"); } break;

            case named_list: { Result = CS("named_list"); } break;

            case def_func: { Result = CS("def_func"); } break;

            case def_func_2: { Result = CS("def_func_2"); } break;

        }
        return Result;
      }


