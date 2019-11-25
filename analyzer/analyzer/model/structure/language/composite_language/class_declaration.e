note
	description: "Holds list of Attributes and Routine Declarations"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_DECLARATION

inherit
	COMPOSITE_LANG[LANGUAGE]

create
	make

feature -- Attributes
	name: STRING
	attr_count: INTEGER
	query_count: INTEGER
	command_count: INTEGER

feature -- Constructor
	make (cn: STRING)
		do
			name := cn
			create children.make
--			create attr.make
--			create queries.make
--			create commands.make
--			add_child(attr)
--			add_child(queries)
--			add_child(commands)
		end

feature -- Commands
	add_attribute (a: ATTRIBUTE_DECLARATION)
		do
--			attr.extend(a)
			add_child(a)
			attr_count := attr_count + 1
		end

	add_query (rout: ROUTINE_DECLARATION)
		do
--			queries.extend(rout)
			add_child(rout)
			query_count := query_count + 1
		end

	add_command (rout: ROUTINE_DECLARATION)
		do
--			commands.extend(rout)
			add_child(rout)
			command_count := command_count + 1
		end

	accept (v: VISITOR)
		do
			v.visit_class_declaration (CURRENT)
		end

feature -- Queries
--	out: STRING
--		do
--			create Result.make_from_string ("  ")
--			Result.append ("class " + name + " {%N")
--			-- run across 3 lists to print out attr, queries, commands
--			Result.append ("}")
--		end

	get_name: STRING
		do
			Result := name
		end

--	get_attr: LINKED_LIST[ATTRIBUTE_DECLARATION]
--		do
--			Result := attr
--		end

--	get_query: LINKED_LIST[ROUTINE_DECLARATION]
--		do
--			Result := queries
--		end

--	get_command: LINKED_LIST[ROUTINE_DECLARATION]
--		do
--			Result := commands
--		end

invariant
	children.count = 3
end
