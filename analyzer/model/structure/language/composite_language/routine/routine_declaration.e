note
	description: "Holds a Parameter obj and a list of Assignments"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ROUTINE_DECLARATION

inherit
	COMPOSITE_LANG[ASSIGNMENT]

--create
--	make

feature -- Attributes
--	name: STRING
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

--	add_assignment (n: STRING; e: EXPRESSION) : ASSIGNMENT
--		local
--			ass: ASSIGNMENT
--		do
--			create ass.make (n, e, CURRENT)
--			children.extend (ass)
--			Result := ass
--		end
feature -- Queries

--	get_name: STRING
--		do
--			Result := name
--		end

	get_type: STRING
		do
			Result := type
		end

	get_para: ARRAY[TUPLE[pn: STRING; pt: STRING]]
		do
			Result := para
		end

	get_para_names: ARRAY[STRING]
		do
			create Result.make_empty
			across
				para is tup
			loop
				if attached {STRING} tup[1] as n then
					Result.force (n, Result.count + 1)
				end
			end
		end

	get_para_type (i: INTEGER) : STRING
		do
			create Result.make_empty
			if attached {STRING} (para[i])[2] as t then
				Result := t
			end
		end

end
