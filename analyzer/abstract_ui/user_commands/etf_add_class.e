note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_CLASS
inherit
	ETF_ADD_CLASS_INTERFACE
create
	make
feature -- command
	add_class(cn: STRING)
		require else
			add_class_precond(cn)
		local
			err: ERRORS
    	do
			-- perform some update on the model state
			if model.being_specified then
				model.set_error_msg (err.assignment_instruction_currently_being_specified (model.routine_being_specified.get_name,
				model.class_being_specified.get_name))
			elseif model.class_name_exists (cn) then
				model.set_error_msg (err.class_name_already_exists (cn))
			else
				model.add_class (cn)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
