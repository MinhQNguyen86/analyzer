note
	description: "Assigns and holds an Expression"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ASSIGNMENT

inherit
	BASIC_LANG

create
	make

feature -- Attributes
--	name: STRING
	rhs: EXPRESSION

feature -- Constructor
	make (cn: STRING; e: EXPRESSION)
		do
			name := cn
			rhs := e
		end

feature -- Commands

	set_expression (e: EXPRESSION)
		do
			rhs := e
		end

	accept (v: VISITOR)
		do
			v.visit_assignment (CURRENT)
		end

feature -- queries

--	get_name: STRING
--		do
--			Result := name
--		end

	get_expression: EXPRESSION
		do
			Result := rhs
		end

end
