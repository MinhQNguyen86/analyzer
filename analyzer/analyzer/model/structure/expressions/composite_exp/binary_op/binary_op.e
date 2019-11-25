note
	description: "Summary description for {BINARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BINARY_OP

inherit
	COMPOSITE_EXP[EXPRESSION]

feature {NONE} -- Constructor
	make
		local
			cur: CURRENT_EXP
			nil: NIL_EXP
		do
			create cur.make
			create nil.make
			create children.make
			children.extend(cur)
			children.extend(nil)
			cur.set_parent (Current)
			nil.set_parent (Current)

		end

feature -- Queries

	left: EXPRESSION
		do
			Result := children[1]
		end

	right: EXPRESSION
		do
			Result := children[2]
		end

feature -- Commands
	set_left(e: EXPRESSION)
		do
			children[1] := e
		end

	set_right(e: EXPRESSION)
		do
			children[2] := e
		end

invariant
	binary_op:
		children.count = 2

end
