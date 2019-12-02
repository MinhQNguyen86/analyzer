note
	description: "Summary description for {COMPOSITE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COMPOSITE[G]

feature {NONE} -- Attributes
	children: LINKED_LIST[G]

feature -- Commands
	add_child (nc: G)
		do
			children.extend (nc)
		end

feature -- Queries
	get_children: LINKED_LIST[G]
		do
			Result := children
		end
end
