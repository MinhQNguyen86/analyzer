note
	description: "Summary description for {ERRORS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	ERRORS

feature
	assignment_instruction_not_being_specified: STRING
		do
			Result := "Error (An assignment instruction is not currently being specified)"
		end
	assignment_instruction_currently_being_specified (r, c: STRING): STRING
		do
			Result := "Error (An assignment instruction is currently being specified for routine " + r + " in class " + c + ")"
		end
	class_name_already_exists (cn: STRING): STRING
		do
			Result := "Error (" + cn + " is already an existing class name)"
		end
	class_non_existing (c: STRING): STRING
		do
			Result := "Error (" + c + " is not an existing class name)"
		end
	feature_to_be_added_exists (cn, fn: STRING): STRING
		do
			Result := "Error (" + fn + " is already an existing feature name in class " + cn + ")"
		end
	para_name_in_list_clash_with_classes (clash: ARRAY[STRING]): STRING
		do
			Result := "Error (Parameter names clash with existing classes:"
			across
				clash.lower |..| clash.count is i
			loop
				Result.append (" " + clash[i])
				if i /= clash.count then
					Result.append (",")
				end
			end
			Result.append(")")
		end
	para_names_contain_duplicates (dup: LINKED_SET[STRING]): STRING
		do
			Result := "Error (Duplicated parameter names:"
			across
				dup.lower |..| dup.count is i
			loop
				Result.append (" " + dup[i])
				if i /= dup.count then
					Result.append (",")
				end
			end
			Result.append (")")
		end
	para_type_invalid (invalid: ARRAY[STRING]): STRING
		do
			Result := "Error (Parameter types do not refer to primitive types or existing classes:"
			across
				invalid.lower |..| invalid.count is i
			loop
				Result.append (" " + invalid[i])
				if i /= invalid.count then
					Result.append (",")
				end
			end
			Result.append (")")
		end
	return_type_invalid (rt: STRING): STRING
		do
			Result := "Error (Return type does not refer to a primitive type or an existing class: " + rt + ")"
		end
	feature_not_exist_in_class (cn, fn: STRING): STRING
		do
			Result := "Error (" + fn + " is not an existing feature name in class " + cn + ")"
		end

	feature_cannot_be_imp (cn, fn: STRING): STRING
		do
			Result := "Error (Attribute " + fn + " in class " + cn + " cannot be specified with an implementation)"
		end
	call_chain_empty: STRING
		do
			Result := "Error (Call chain is empty)"
		end

end
