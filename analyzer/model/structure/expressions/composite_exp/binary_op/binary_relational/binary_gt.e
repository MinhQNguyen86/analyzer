note
	description: "Summary description for {BINARY_GT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_GT

inherit
	BINARY_OP

create
	make

feature -- Attributes
	value: STRING = ">"

feature -- Queries
	accept(v: VISITOR)
		do
			v.visit_binary_gt (Current)
		end

end
