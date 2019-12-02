note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_LOGICAL_NEGATION
inherit
	ETF_LOGICAL_NEGATION_INTERFACE
create
	make
feature -- command
	logical_negation
		local
			err: ERRORS
    	do
			-- perform some update on the model state
			if not model.being_specified then
				model.set_error_msg (err.assignment_instruction_not_being_specified)
			else
				model.logical_negation
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
