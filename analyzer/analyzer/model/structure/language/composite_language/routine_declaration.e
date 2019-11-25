note
	description: "Holds a Parameter obj and a list of Assignments"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_DECLARATION

inherit
	COMPOSITE_LANG[ASSIGNMENT]

create
	make

feature -- Attributes
	name: STRING
	type: STRING
	para: ARRAY[TUPLE[pn: STRING; pt: STRING]]
	-- children holds ASSIGNMENT

feature -- Constructor
	make (rn, t: STRING; p: ARRAY[TUPLE[pn, pt: STRING]])
		do
			create children.make -- ASSIGNMENT
			name := rn
			type := t
			para := p
		end

feature -- Commands
	add_assignment (a: ASSIGNMENT)
		do
			children.extend (a)
		end

	accept (v: VISITOR)
		do
			v.visit_routine_declaration (CURRENT)
		end

feature -- Queries
--	out : STRING
--		do
--			create Result.make_from_string ("  ")
--			Result.append (type + "  " + name + "  ")
--			across
--				para.lower |..| para.upper is i
--			loop
--				Result.append (para[i].t + " " + para[i].n)
--			end
--			Result.append ("  {%N")
--			-- loop across assigments (children)

--			Result.append ("}")
--		end

	get_name: STRING
		do
			Result := name
		end

	get_type: STRING
		do
			Result := type
		end

	get_para: ARRAY[TUPLE[STRING, STRING]]
		do
			Result := para
		end

end
