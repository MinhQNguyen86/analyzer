note
	description: "Summary description for {BINARY_MULT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_MULT

inherit
	BINARY_OP

create
	make

feature -- Attributes
	value: STRING = "*"

feature -- Queries
	accept(v: VISITOR)
		do
			v.visit_binary_mult (Current)
		end
end
