note
	description: "Summary description for {BINARY_ADD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_ADD

inherit
	BINARY_OP

create
	make

feature -- Attributes
	value: STRING = "+"

feature -- Queries
	accept(v: VISITOR)
		do
			v.visit_binary_add (Current)
		end
end
