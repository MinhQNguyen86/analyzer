note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_DISJUNCTION
inherit
	ETF_DISJUNCTION_INTERFACE
create
	make
feature -- command
	disjunction
		local
			err: ERRORS
    	do
			-- perform some update on the model state
			if not model.being_specified then
				model.set_error_msg (err.assignment_instruction_not_being_specified)
			else
				model.disjunction
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
