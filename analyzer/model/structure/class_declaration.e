note
	description: "Summary description for {CLASS_DECLARATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASS_DECLARATION

inherit
	ANY
		redefine
			out
		end
	GRAMMAR
		rename
			out as g_out
		select
			g_out
		end
	COMPOSITE[LIST[GRAMMAR]]
		rename
			out as c_out
		end

create
	make

feature -- Attributes
	name: STRING
	attr: LINKED_LIST[GRAMMAR]
	queries: LINKED_LIST[GRAMMAR]
	commands: LINKED_LIST[GRAMMAR]

feature -- Constructor
	make (cn: STRING)
		do
			name := cn
			create children.make
			create attr.make
			create queries.make
			create commands.make
			add_child(attr)
			add_child(queries)
			add_child(commands)
--			list.extend(attr)
--			list.extend(queries)
--			list.extend(commands)
		end

feature -- Commands
	add_attribute (a: ATTRIBUTE_DECLARATION)
		do
			attr.extend(a)
		end

	add_query (rout: ROUTINE_DECLARATION)
		do
			queries.extend(rout)
		end

	add_command (rout: ROUTINE_DECLARATION)
		do
			commands.extend(rout)
		end

feature -- Queries
	out: STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("class " + name + " {%N")
			-- run across 3 lists to print out attr, queries, commands
			Result.append ("}")
		end

	get_class_name: STRING
		do
			Result := name
		end
invariant
	children.count = 3
end
