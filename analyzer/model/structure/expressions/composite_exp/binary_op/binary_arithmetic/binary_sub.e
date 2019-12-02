note
	description: "Summary description for {BINARY_SUB}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_SUB

inherit
	BINARY_OP

create
	make

feature -- Attributes
	value: STRING = "-"
	
feature -- Queries
	accept(v: VISITOR)
		do
			v.visit_binary_sub (Current)
		end

end
