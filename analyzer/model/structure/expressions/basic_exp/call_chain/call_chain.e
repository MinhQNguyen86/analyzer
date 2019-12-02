note
	description: "Summary description for {CALL_CHAIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALL_CHAIN

inherit
	BASIC_EXP

create
	make

feature -- Attribute
	chains: ARRAY[STRING]

feature -- Constructor
	make (a: ARRAY[STRING])
		do
			chains := a
		end

feature -- Queries

	get_chain: ARRAY[STRING]
		do
			Result := chains
		end

	accept(v: VISITOR)
		do
			v.visit_call_chain (Current)
		end

end
