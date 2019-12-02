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
--	name: STRING
	attr_count: INTEGER
	query_count: INTEGER
	command_count: INTEGER
	type_correct: BOOLEAN
	attr: LINKED_LIST[ATTRIBUTE_DECLARATION]
	query: LINKED_LIST[QUERY_DECLARATION]
	command: LINKED_LIST[COMMAND_DECLARATION]

feature -- Constructor
	make (cn: STRING)
		do
			name := cn
			create children.make
			create attr.make
			create query.make
			create command.make
			type_correct := True
		end

feature -- Commands
	add_attribute (a: ATTRIBUTE_DECLARATION)
		do
			attr.extend(a)
			add_child(a)
			attr_count := attr_count + 1
		end

	add_query (rout: QUERY_DECLARATION)
		do
			query.extend(rout)
			add_child(rout)
			query_count := query_count + 1
		end

	add_command (rout: COMMAND_DECLARATION)
		do
			command.extend(rout)
			add_child(rout)
			command_count := command_count + 1
		end

	set_type_correct (b: BOOLEAN)
		do
			type_correct := b
		end

	accept (v: VISITOR)
		do
			v.visit_class_declaration (CURRENT)
		end

feature -- Queries

--	get_name: STRING
--		do
--			Result := name
--		end

	get_attr: LINKED_LIST[ATTRIBUTE_DECLARATION]
		do
			Result := attr
		end

	get_query: LINKED_LIST[QUERY_DECLARATION]
		do
			Result := query
		end

	get_command: LINKED_LIST[COMMAND_DECLARATION]
		do
			Result := command
		end
end
