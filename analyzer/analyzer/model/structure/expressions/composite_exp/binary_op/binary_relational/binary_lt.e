note
	description: "Summary description for {BINARY_LT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_LT

inherit
	BINARY_OP

create
	make

feature -- Attributes
	value: STRING = "<"

feature -- Output
--	out: STRING
--		do
--			Result := "(" + left.out + " < " + right.out + ")"

--		end

feature -- Queries
	accept(v: VISITOR)
		do
			v.visit_binary_lt (Current)
		end
end
