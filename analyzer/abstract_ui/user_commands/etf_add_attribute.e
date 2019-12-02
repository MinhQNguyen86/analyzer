note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_ATTRIBUTE
inherit
	ETF_ADD_ATTRIBUTE_INTERFACE
create
	make
feature -- command
	add_attribute(cn: STRING ; fn: STRING ; ft: STRING)
		require else
			add_attribute_precond(cn, fn, ft)
		local
			err: ERRORS
    	do
			-- perform some update on the model state
			if model.being_specified then
				model.set_error_msg (err.assignment_instruction_currently_being_specified (model.routine_being_specified.get_name,
				model.class_being_specified.get_name))
			elseif not model.class_name_exists (cn) then
				model.set_error_msg (err.class_non_existing (cn))
			elseif model.feature_exist_in_class (cn, fn) then
				model.set_error_msg (err.feature_to_be_added_exists (cn, fn))
			elseif not model.valid_return_type (ft) then
				model.set_error_msg (err.return_type_invalid (ft))
			else
				model.add_attribute (cn, fn, ft)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
