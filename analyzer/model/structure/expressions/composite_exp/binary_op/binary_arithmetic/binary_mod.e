note
	description: "Summary description for {BINARY_MOD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_MOD

inherit
	BINARY_OP

create
	make

feature -- Attributes
	value: STRING = "%%"

feature -- Queries
	accept(v: VISITOR)
		do
			v.visit_binary_mod (Current)
		end
end
