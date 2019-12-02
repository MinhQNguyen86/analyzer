note
	description: "Summary description for {BINARY_EQ}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_EQ

inherit
	BINARY_OP

create
	make

feature -- Attributes
	value: STRING = "=="

feature -- Queries
	accept(v: VISITOR)
		do
			v.visit_binary_eq (Current)
		end
end
