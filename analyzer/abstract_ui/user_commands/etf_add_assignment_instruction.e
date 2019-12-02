note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_ASSIGNMENT_INSTRUCTION
inherit
	ETF_ADD_ASSIGNMENT_INSTRUCTION_INTERFACE
create
	make
feature -- command
	add_assignment_instruction(cn: STRING ; fn: STRING ; n: STRING)
		require else
			add_assignment_instruction_precond(cn, fn, n)
		local
			err: ERRORS
    	do
			-- perform some update on the model state
			if model.being_specified then
				model.set_error_msg (err.assignment_instruction_currently_being_specified (model.routine_being_specified.get_name,
				model.class_being_specified.get_name))
			elseif not model.class_name_exists (cn) then
				model.set_error_msg (err.class_non_existing (cn))
			elseif not model.feature_exist_in_class (cn, fn) then
				model.set_error_msg (err.feature_not_exist_in_class (cn, fn))
			elseif not model.feature_can_be_imp (cn, fn) then
				model.set_error_msg (err.feature_cannot_be_imp (cn, fn))
			else
				model.add_assignment_instruction (cn, fn, n)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
