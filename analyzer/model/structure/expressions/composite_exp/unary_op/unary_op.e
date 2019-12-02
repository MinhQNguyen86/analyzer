note
	description: "Summary description for {UNARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	UNARY_OP

inherit
	COMPOSITE_EXP[EXPRESSION]

feature {NONE} -- Constructor
	make
		local
			cur: CURRENT_EXP
		do
			create cur.make
			create children.make
			children.extend (cur)
			cur.set_parent (Current)

		end

feature -- Queries

	get_exp: EXPRESSION
		do
			Result := children[1]
		end

feature -- Commands

	set_exp(e: EXPRESSION)
		do
			children[1] := e
		end

invariant
	children.count = 1

end
