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
	value: STRING
	chains: ARRAY[STRING]

feature -- Constructor
	make (n: STRING; a: ARRAY[STRING])
		do
			value := n
			chains := a
		end

feature -- Output
--	out: STRING
--		do
--			create Result.make_from_string(name)
--			if not chains.is_empty then
--				Result.append (".")
--				across
--					chains is i
--				loop
--					Result.append(i.out)
--				end
--			end
--		end

feature -- Queries

	get_value: STRING
		do
			Result := value
		end

	get_chain: ARRAY[STRING]
		do
			Result := chains
		end

	accept(v: VISITOR)
		do
			v.visit_call_chain (Current)
		end

end
