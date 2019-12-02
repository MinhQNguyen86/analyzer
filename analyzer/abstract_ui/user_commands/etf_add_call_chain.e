note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_CALL_CHAIN
inherit
	ETF_ADD_CALL_CHAIN_INTERFACE
create
	make
feature -- command
	add_call_chain(chain: ARRAY[STRING])
		local
			err: ERRORS
    	do
			-- perform some update on the model state
			if not model.being_specified then
				model.set_error_msg (err.assignment_instruction_not_being_specified)
			elseif chain.is_empty then
				model.set_error_msg (err.call_chain_empty)
			else
				model.add_call_chain (chain)
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
