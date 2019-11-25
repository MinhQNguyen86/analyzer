note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature -- Attributes
	program: LINKED_LIST[CLASS_DECLARATION]
	num_classes: INTEGER

	stack: LINKED_STACK[NULL_EXP] -- holds ? and nil
	assign_being_specified: ASSIGNMENT
	being_specified: BOOLEAN

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		local
			c: CURRENT_EXP
		do
			create program.make
			create stack.make
			create c.make
			create assign_being_specified.make ("", create {CURRENT_EXP}.make)
			stack.compare_objects
			num_classes := 0
			being_specified := False
		end

feature -- model operations

	get_class_declaration(cn: STRING): CLASS_DECLARATION
		require
			existing_class:
				True
		do
			-- helper
			create Result.make ("") -- empty class
			across
				program is i
			loop
				if i.get_name ~ cn then
					Result := i
				end
			end
		end

	add_class(cn: STRING)
		local
			child: CLASS_DECLARATION
		do
			-- add class name to list
			create child.make (cn)
			program.extend (child)
			num_classes := num_classes + 1
		end

	add_attribute(cn, fn, ft: STRING)
		local
			attr: ATTRIBUTE_DECLARATION
			c: CLASS_DECLARATION
		do
			-- add to class 'cn' new attr 'fn' w/ type 'ft'
			create attr.make (fn, ft)
			c := get_class_declaration (cn)
			c.add_attribute (attr)
		end

	add_command(cn, fn: STRING; ps: ARRAY[TUPLE[pn, pt: STRING]])
		local
			command: ROUTINE_DECLARATION
			c: CLASS_DECLARATION
		do
			-- add to class 'cn' new command 'fn' w/ list of
			-- parameters 'ps'. Each parameter is a tuple
			-- w/ parameter name 'pn' and type 'pt'
			-- 'pt' can be int/boolean/class_name
			create command.make (fn, "void", ps)
			c := get_class_declaration (cn)
			c.add_command (command)
		end

	add_query(cn, fn, rt: STRING; ps: ARRAY[TUPLE[pn, pt: STRING]])
		local
			query: ROUTINE_DECLARATION
			c: CLASS_DECLARATION
		do
			-- add to class 'cn' new query 'fn' w/ list of
			-- parameters 'ps' and return type 'rt'.
			-- Each parameter is a tuple
			-- w/ parameter name 'pn' and type 'pt'
			-- 'pt' can be int/boolean/class_name
			create query.make (fn, rt, ps)
			c := get_class_declaration (cn)
			c.add_query (query)
		end

	add_assignment_instruction(cn, fn, n: STRING)
		local
			ass: ASSIGNMENT
			e: CURRENT_EXP
			c: CLASS_DECLARATION
		do
			-- assign to variable named 'n' in routine 'fn'
			-- of class 'cn'. 'n' should be 'Result' (if query)
			-- or an attribute name in current class
			create e.make
			create ass.make (n, e)
			c := get_class_declaration (cn)
			across
				c.get_children is i
			loop
				if attached {ROUTINE_DECLARATION} i as rt then
					if rt.get_name ~ fn then
						rt.add_assignment (ass)
					end
				end
			end

			assign_being_specified := ass
			stack.put (e)
			being_specified := True
		end

	add_call_chain(chain: ARRAY[STRING])
		require
			being_specified
		local
			c: CALL_CHAIN
		do
			create c.make (chain[1], chain.subarray (2, chain.upper))
			visit_pre_order(c)
		end

	visit_pre_order(to_be_added: EXPRESSION)
		local
			parent: EXPRESSION
			c: CURRENT_EXP
		do
			if attached {CURRENT_EXP} stack.item as r then
				parent := r.get_parent
				stack.remove
				to_be_added.set_parent (parent)
				-- check the expression to be added to see if it's binary/unary
				-- because we want to add it's children to the stack
				if attached {BINARY_OP} to_be_added as bi then
					-- right side is always nil, when binary_op is first created
					if attached {NIL_EXP} bi.right as e then
						stack.put (e)
					end
					if attached {CURRENT_EXP} bi.left as e then
						stack.put (e)
					end
				elseif attached {UNARY_OP} to_be_added as uni  then
					if attached {CURRENT_EXP} uni.get_exp as e then
						stack.put (e)
					end
				end

				if attached {BINARY_OP} parent as p then
					if attached {CURRENT_EXP} p.right as p_right then
						p.set_right (to_be_added)
					elseif attached {CURRENT_EXP} p.left as p_left then
						p.set_left (to_be_added)
					end
				elseif attached {UNARY_OP} parent as p then
					p.set_exp (to_be_added)
				elseif attached {CURRENT_EXP} parent as p then -- first time being added
					assign_being_specified.set_expression (to_be_added)
				end
			end

			if attached {NIL_EXP} stack.item as n then
				parent := n.get_parent
				if attached {BINARY_OP} parent as p then
					stack.remove
					create c.make
					c.set_parent (p)
					stack.put (c)
--					if attached {NIL_EXP} p.left as p_left then
--						p.set_left (c)
--					else -- is always on right side
					if attached {NIL_EXP} p.right as p_right then
						p.set_right (c)
					end
				end
			end

--			if attached {CURRENT_EXP} stack.item as r then
--				-- get parent
--				-- attached {BINARY_OP}
--				--  check if left is ?
--				--    set right to ? (MAYBE NOT)
--				--    parent.set_left to r
--				--    pop ? from stack
--				--  check if right is ?
--				--    parent.set_right to r
--				-- attached {UNARY_OP}
--				--  pop ?
--				--  parent.set_exp to to_be_added
--				-- or {CURRENT_EXP}
--				--  assign_being_specified.set_exp(to_be_added)
--				--  push to_be_added.right, left on stack
--			end
--			if attached {NIL_EXP} stack_item as n then
--				-- get parent

--				-- attached {BINARY_OP}
--				--  check if left is nil
--				--    pop nil
--				--    create ?; set_parent to attached {binary_OP}
--				--    push ?
--				--    set left to ?
--				--  check if right is ?
--				--    pop nil
--				--    create ?; set_parent to attached {binary_OP}
--				--    push ?
--				--    set right to ?
--			end

		end

	bool_value (c: BOOLEAN)
		require
			valid_assigning:
				being_specified
			expression_not_filled:
				not stack.is_empty
		local
			b: BOOLEAN_CONSTANT
		do
			create b.make (c)
			visit_pre_order (b)
		end

	int_value (c: INTEGER)
		require
			being_specified
		local
			i: INTEGER_CONSTANT
		do
			create i.make (c)
			visit_pre_order(i)
		end

	addition
		require
			being_specified
		local
			a: BINARY_ADD
		do
			create a.make
			visit_pre_order (a)
		end

	subtraction
		require
			being_specified
		local
			s: BINARY_SUB
		do
			create s.make
			visit_pre_order(s)
		end

	multiplication
		require
			being_specified
		local
			m: BINARY_MULT
		do
			create m.make
			visit_pre_order(m)
		end

	quotient
		require
			being_specified
		local
			q: BINARY_DIV
		do
			create q.make
			visit_pre_order(q)
		end

	modulo
		require
			being_specified
		local
			m: BINARY_MOD
		do
			create m.make
			visit_pre_order(m)
		end

	conjunction
		require
			being_specified
		local
			c: BINARY_AND
		do
			-- &&
			create c.make
			visit_pre_order(c)
		end

	disjunction
		require
			being_specified
		local
			d: BINARY_OR
		do
			-- ||
			create d.make
			visit_pre_order(d)
		end

	equals
		require
			being_specified
		local
			e: BINARY_EQ
		do
			create e.make
			visit_pre_order(e)
		end

	greater_than
		require
			being_specified
		local
			g: BINARY_GT
		do
			create g.make
			visit_pre_order(g)
		end

	less_than
		require
			being_specified
		local
			l: BINARY_LT
		do
			create l.make
			visit_pre_order(l)
		end

	numerical_negation
		require
			being_specified
		local
			n: UNARY_NUM_NEG
		do
			create n.make
			visit_pre_order(n)
		end

	logical_negation
		require
			being_specified
		local
			l: UNARY_LOG_NEG
		do
			create l.make
			visit_pre_order(l)
		end

	default_update
			-- Perform update to the model state.
		do
		end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		do
			create Result.make_from_string ("  ")
			Result.append ("Status: %N")
			Result.append ("  ")
			Result.append ("Number of classes being specified: " + num_classes.out + "%N")
			across
				program is classes
			loop
				Result.append ("    " + classes.get_name + "%N")
				Result.append ("      " + "Number of attributes: " + classes.get_attr.count.out + "%N")
--				across
--					classes.get_attr.lower |..| classes.get_attr.count is i
--				loop
--					Result.append ("        + " + classes.get_attr[i].get_name + ": " +
--						classes.get_attr[i].get_type + "%N")
--				end

--				Result.append ("      " + "Number of queries: " + classes.get_query.count.out + "%N")
--				across
--					classes.get_query.lower |..| classes.get_query.count is i
--				loop
--					if classes.get_query[i].get_para.is_empty then
--						Result.append ("        + " + classes.get_query[i].get_name + "%N")
--					else
--						Result.append ("        + " + classes.get_query[i].get_name + "(")
--						across
--							1 |..| classes.get_query[i].get_para.count is j -- tuple[string, string]
--						loop
--							Result.append (classes.get_query[i].get_para[j])
--							if j /= classes.get_query[i].get_para.count then
--								Result.append (", ")
--							end
--						end
--						Result.append ("%N")
--					end
--				end

--				Result.append ("      " + "Number of commands: " + classes.get_command.count + "%N")
--				across
--					 as
--				loop

--				end
			end

		end

invariant
	num_classes >= 0

end




