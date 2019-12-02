note
	description: "Summary description for {BINARY_OR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_OR

inherit
	BINARY_OP

create
	make

feature -- Attributes
	value: STRING = "||"


feature -- Queries
	accept(v: VISITOR)
		do
			v.visit_binary_or (Current)
		end
end
