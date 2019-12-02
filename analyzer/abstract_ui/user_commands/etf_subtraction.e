note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_SUBTRACTION
inherit
	ETF_SUBTRACTION_INTERFACE
create
	make
feature -- command
	subtraction
		local
			err: ERRORS
    	do
			-- perform some update on the model state
			if not model.being_specified then
				model.set_error_msg (err.assignment_instruction_not_being_specified)
			else
				model.subtraction
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
