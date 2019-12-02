note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_INT_VALUE
inherit
	ETF_INT_VALUE_INTERFACE
create
	make
feature -- command
	int_value(c: INTEGER_32)
		local
			err: ERRORS
    	do
			-- perform some update on the model state
			if not model.being_specified then
				model.set_error_msg (err.assignment_instruction_not_being_specified)
			else
				model.int_value (c)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
