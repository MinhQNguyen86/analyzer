note
	description: "Summary description for {ATTRIBUTE_DECLARATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ATTRIBUTE_DECLARATION

inherit
	BASIC_LANG

create
	make

feature -- Attributes
	name: STRING
	type: STRING

feature -- Constructor
	make (cn, t: STRING)
		do
			name := cn
			type := t
		end

feature -- Commands

	accept (v: VISITOR)
		do
			v.visit_attribute_declaration (CURRENT)
		end

feature -- Queries
--	out : STRING
--		do
--			create Result.make_empty
--			Result.append (type + " ")
--			Result.append (name + ";%N")
--		end

	get_name: STRING
		do
			Result := name
		end

	get_type: STRING
		do
			Result := type
		end

end
