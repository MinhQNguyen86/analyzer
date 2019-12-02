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

feature -- Queries
	accept(v: VISITOR)
		do
			v.visit_binary_lt (Current)
		end
end
