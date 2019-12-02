note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ANALYZER

inherit
	ANY
		redefine
			out
		end

create {ANALYZER_ACCESS}
	make

feature -- Attributes
	program: LINKED_LIST[CLASS_DECLARATION]
	stack: LINKED_STACK[NULL_EXP] -- holds ? and nil
	num_classes: INTEGER

	-- Add assignment
	being_specified: BOOLEAN
	assign_being_specified: ASSIGNMENT
	class_being_specified: CLASS_DECLARATION
	routine_being_specified: ROUTINE_DECLARATION

	-- Check type
	type_checking: BOOLEAN
	t_check_msg: STRING

	-- Print Pretty
	printing_pretty: BOOLEAN
	printer: PRETTY_PRINT
	p_msg: STRING

	error_msg: STRING

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		local
			c: CURRENT_EXP
		do
			create program.make
			create stack.make
			create c.make
			create class_being_specified.make("")
			create {COMMAND_DECLARATION} routine_being_specified.make("", "", <<["",""]>>)
			create assign_being_specified.make ("", create {CURRENT_EXP}.make)
			create t_check_msg.make_empty
			create printer.make
			create error_msg.make_from_string("OK")
			create p_msg.make_empty
			stack.compare_objects
			program.compare_objects
			num_classes := 0
			being_specified := False
		end

feature -- model operations

	pretty_print
		local
			pp: PRETTY_PRINT
		do
			create p_msg.make_empty
			printing_pretty := True

			across
				program.lower |..| program.count is i
			loop
				if i /= program.lower then
					p_msg.append ("%N")
				end
				create pp.make
				program[i].accept(pp)
				p_msg.append(pp.get_msg)
			end
		end

	type_check
		require
			not being_specified
		local
			type : STRING
			type_correct: BOOLEAN
			checker: TYPE_CHECKER
			non_correct_assignments: ARRAY[STRING]
			pp: PRETTY_PRINT
		do
			type_checking := True

			create type.make_empty
			create non_correct_assignments.make_empty
			type_correct := True

			across
				program.lower |..| program.count is i -- CLASS_DECLARATION
			loop
--				run through children to find cmd or query
				across
					program[i].get_children is lang -- attr/query/command
				loop

					if attached {ROUTINE_DECLARATION} lang as rout then
						-- look at ASSIGNMENTS {name = expression}
						across
							rout.get_children is assignn -- assignment := STRING, EXPRESSION
						loop
							-- find attribute w/ same name as assignment, then set type
							-- The LHS of a variable assignment may refer to an existing attribute or
							-- reserved variable Result if the current routine in question is a query.
							create checker.make (program, program[i], rout)
							across
								program[i].get_attr is a2
							loop
								if a2.get_name ~ assignn.get_name then
									type := a2.get_type
								end
							end

							-- It is considered as type-correct if the RHS of a variable assignment
							-- refers to parameter(s) of the routine in question.

							if assignn.get_name ~ "Result" then
								type := rout.get_type
							end

							if type.is_empty then -- did not find assignment
								type_correct := False
								program[i].set_type_correct(False)
							else
								assignn.get_expression.accept(checker)
								if not checker.type_correct or (type /~ checker.type) then
									type_correct := False
									program[i].set_type_correct(False)
								end
							end

							if not type_correct then
								create pp.make
								assignn.get_expression.accept(pp)
								non_correct_assignments.force ("%N    " + assignn.get_name + " = " + pp.get_msg +
									" in routine " + rout.get_name + " is not type-correct." , non_correct_assignments.count + 1)
							end

						end -- end of loop ass
					end

				end -- loop query/cmd

				if type_correct then
					program[i].set_type_correct (True)
				end

				if i /= program.lower then
					t_check_msg.append ("%N")
				end

				if program[i].type_correct then
					t_check_msg.append ("  class " + program[i].get_name + " is type-correct.")
				else
					t_check_msg.append ("  class " + program[i].get_name + " is not type-correct:")
					across
						non_correct_assignments is s
					loop
						t_check_msg.append (s)
					end
				end
			end -- loop for program
		end -- do

	add_class(cn: STRING)
		require
			not being_specified
			cn_not_already_exist:
				not class_name_exists (cn)
		local
			child: CLASS_DECLARATION
		do
			-- add class name to list
			create child.make (cn)
			program.extend (child)
			num_classes := num_classes + 1
		end

	add_attribute(cn, fn, ft: STRING)
		require
			not being_specified
			class_exists:
				class_name_exists (cn)

			feature_not_exist:
				feature_not_exists (cn, fn)

			return_type_valid:
				valid_return_type (ft)

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
		require
			not being_specified
			class_exists:
				class_name_exists (cn)

			feature_not_exist:
				feature_not_exists (cn, fn)

			para_not_clash_with_classes:
				para_name_list_not_clash_with_class_names (ps)

			para_names_not_dup:
				not_duplicate_para_names (ps)

			para_types_valid:
				para_not_incorrect_type (ps)

		local
			command: COMMAND_DECLARATION
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
		require
			not being_specified
			class_exists:
				class_name_exists (cn)

			feature_not_exist:
				feature_not_exists (cn, fn)

			para_not_clash_with_classes:
				para_name_list_not_clash_with_class_names (ps)

			para_names_not_dup:
				not_duplicate_para_names (ps)

			para_types_valid:
				para_not_incorrect_type (ps)

			return_type_valid:
				valid_return_type (rt)

		local
			query: QUERY_DECLARATION
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
		require
			not being_specified
			class_exists:
				class_name_exists (cn)
			feature_exist_in_class:
				feature_exist_in_class (cn, fn)
			feature_not_an_attr_in_class:
				feature_can_be_imp (cn, fn)
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
						routine_being_specified := rt
					end
				end
			end

			class_being_specified := c
			assign_being_specified := ass
			stack.put (e)
			being_specified := True
		end

	add_call_chain(chain: ARRAY[STRING])
		require
			being_specified
			not chain.is_empty
		local
			c: CALL_CHAIN
		do
			create c.make (chain)
			expression_value (c)
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
			elseif attached {NIL_EXP} stack.item as n then
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

	expression_value (c: EXPRESSION)
		require
			being_specified
		do
			visit_pre_order(c)
			if (not stack.is_empty) and then stack.item.get_value ~ "nil" then
				visit_pre_order(c)
			end
		end

	bool_value (c: BOOLEAN)
		require
			being_specified
		local
			b: BOOLEAN_CONSTANT
		do
			create b.make (c)
--			visit_pre_order (b)
			expression_value (b)
		end

	int_value (c: INTEGER)
		require
			being_specified
		local
			i: INTEGER_CONSTANT
		do
			create i.make (c)
--			visit_pre_order(i)
			expression_value (i)
		end

	addition
		require
			being_specified
		local
			a: BINARY_ADD
		do
			create a.make
--			visit_pre_order (a)
			expression_value (a)
		end

	subtraction
		require
			being_specified
		local
			s: BINARY_SUB
		do
			create s.make
--			visit_pre_order(s)
			expression_value (s)
		end

	multiplication
		require
			being_specified
		local
			m: BINARY_MULT
		do
			create m.make
--			visit_pre_order(m)
			expression_value (m)
		end

	quotient
		require
			being_specified
		local
			q: BINARY_DIV
		do
			create q.make
--			visit_pre_order(q)
			expression_value (q)
		end

	modulo
		require
			being_specified
		local
			m: BINARY_MOD
		do
			create m.make
--			visit_pre_order(m)
			expression_value (m)
		end

	conjunction
		require
			being_specified
		local
			c: BINARY_AND
		do
			-- &&
			create c.make
--			visit_pre_order(c)
			expression_value (c)
		end

	disjunction
		require
			being_specified
		local
			d: BINARY_OR
		do
			-- ||
			create d.make
--			visit_pre_order(d)
			expression_value (d)
		end

	equals
		require
			being_specified
		local
			e: BINARY_EQ
		do
			create e.make
--			visit_pre_order(e)
			expression_value (e)
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
--			visit_pre_order(l)
			expression_value (l)
		end

	numerical_negation
		require
			being_specified
		local
			n: UNARY_NUM_NEG
		do
			create n.make
--			visit_pre_order(n)
			expression_value (n)
		end

	logical_negation
		require
			being_specified
		local
			l: UNARY_LOG_NEG
		do
			create l.make
--			visit_pre_order(l)
			expression_value (l)
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

feature -- Auxiliary
	set_error_msg (s: STRING)
		do
			error_msg := s
		end

	get_class_declaration(cn: STRING): CLASS_DECLARATION
	-- Get the CLASS with name cn from list 'program'
		require
			existing_class:
				True
		do
			create Result.make ("") -- empty class
			across
				program is i
			loop
				if i.get_name ~ cn then
					Result := i
				end
			end
		end

	class_name_exists (cn: STRING) : BOOLEAN
	-- Checks if the class name exists
		do
			Result := (across
				program is c
			some
				c.get_name ~ cn
			end)
		end

	feature_not_exists (cn, fn: STRING) : BOOLEAN
		do
			Result := (across
				((get_class_declaration(cn)).get_children) is fd
			all
				fd.get_name /~ fn
			end)
		end

	para_name_list_not_clash_with_class_names (ps: ARRAY[TUPLE[pn, pt: STRING]]) : BOOLEAN
		do
			Result :=
			(across
				ps is tup
			all
				across
					program is cl
				all
					tup.pn /~ cl.get_name and tup.pn /~ "INTEGER" and tup.pn /~ "BOOLEAN"
				end
			end)
		end

	para_list_of_clashing_names (ps: ARRAY[TUPLE[pn, pt: STRING]]): ARRAY[STRING]
		do
			create Result.make_empty
			across
				ps is tup
			loop
				across
					program is cl
				loop
					if tup.pn ~ cl.get_name then
						Result.force(tup.pn, Result.count + 1)
					end
				end
				if tup.pn ~ "INTEGER" or tup.pn ~ "BOOLEAN" then
					Result.force(tup.pn, Result.count + 1)
				end
			end
		end

	not_duplicate_para_names (ps: ARRAY[TUPLE[pn, pt: STRING]]): BOOLEAN
		do
			Result :=
			(across
				ps.lower |..| (ps.upper - 1) is i
			all
				across
					(i + 1) |..| ps.upper is j
				all
					ps[i].pn /~ ps[j].pn
				end
			end)
		end

	duplicate_para_list (ps: ARRAY[TUPLE[pn, pt: STRING]]): LINKED_SET[STRING]
		local
			set: LINKED_SET[STRING]
			c: INTEGER
		do
			create Result.make
			create set.make
			set.compare_objects
			Result.compare_objects

			across
				ps is tup
			loop
				c := set.count
				set.put (tup.pn)
				if set.count > c then
					-- tup.pn was add
				elseif set.count = c then
					-- tup.pn was not added
					Result.force(tup.pn)
				end
			end

		end

	para_not_incorrect_type (ps: ARRAY[TUPLE[pn, pt: STRING]]): BOOLEAN
		do
			Result :=
			(across
				ps is tup
			all
				tup.pt ~ "INTEGER" or else tup.pt ~ "BOOLEAN" or else class_name_exists (tup.pt)
			end)
		end

	para_invalid_types (ps: ARRAY[TUPLE[pn, pt: STRING]]): ARRAY[STRING]
		do
			create Result.make_empty
			across
				ps is tup
			loop
				if tup.pt /~ "INTEGER" or tup.pt /~ "BOOLEAN" or (not class_name_exists (tup.pt)) then
					Result.force (tup.pt, Result.count + 1)
				end
			end
		end

	valid_return_type (rt: STRING): BOOLEAN
		do
			Result := rt ~ "INTEGER" or else rt ~ "BOOLEAN" or else class_name_exists (rt)
		end

	feature_exist_in_class (cn, fn: STRING): BOOLEAN
		do
			Result := not feature_not_exists(cn, fn)
		end

	feature_can_be_imp (cn, fn: STRING): BOOLEAN
		do
			-- fn is actually attr in cn
			Result :=
			(across
				((get_class_declaration(cn)).get_attr) is ad
			all
				ad.get_name /~ fn
			end)
		end

feature -- queries
	out : STRING
		do
			create Result.make_empty
			if stack.is_empty then
				being_specified := False
			end

			if type_checking then
				Result.append(t_check_msg)
				create t_check_msg.make_empty
				type_checking := False
			elseif printing_pretty then
				Result.append (p_msg)
				create p_msg.make_empty
				printing_pretty := False
			else
				Result.append ("  ")
				Result.append ("Status: " + error_msg.out + ".%N")
				Result.append ("  ")
				Result.append ("Number of classes being specified: " + num_classes.out)

				across
					program is classes
				loop
					Result.append ("%N    " + classes.get_name)

					-- Attributes
					Result.append ("%N      " + "Number of attributes: " + classes.attr_count.out)
					across
						classes.get_children is i
					loop
						if attached {ATTRIBUTE_DECLARATION} i as a_i then
							Result.append ("%N        + " + a_i.get_name + ": " + a_i.get_type)
						end
					end
					-- Queries
					Result.append ("%N      " + "Number of queries: " + classes.query_count.out)
					across
						classes.get_children is i
					loop
						if attached {QUERY_DECLARATION} i as a_i then
							Result.append ("%N        + " + a_i.get_name)
							across
								a_i.get_para.lower |..| a_i.get_para.upper is n
							loop
								-- add (
								if n = a_i.get_para.lower then
									Result.append("(")
								end
								-- add name
								if attached {STRING} ((a_i.get_para[n])[2]) as t_a then
									Result.append(t_a)
								end
								-- add ,
								if n /= a_i.get_para.upper then
									Result.append(", ")
								end
								-- add )
								if n = a_i.get_para.upper then
									Result.append(")")
								end
							end
							Result.append (": " + a_i.get_type)
						end
					end -- end of query

					-- Commands
					Result.append ("%N      " + "Number of commands: " + classes.command_count.out)
					across
						classes.get_children is i
					loop
						if attached {COMMAND_DECLARATION} i as a_i then
							Result.append ("%N        + " + a_i.get_name)
							across
								a_i.get_para.lower |..| a_i.get_para.upper is n
							loop
								-- add (
								if n = a_i.get_para.lower then
									Result.append("(")
								end
								-- add name
								if attached {STRING} ((a_i.get_para[n])[2]) as t_a then
									Result.append(t_a)
								end
								-- add ,
								if n /= a_i.get_para.upper then
									Result.append(", ")
								end
								-- add )
								if n = a_i.get_para.upper then
									Result.append(")")
								end
							debug
								end -- end of para
							end
						end
					end -- end of command

				end -- end of classes

				if being_specified then
							assign_being_specified.get_expression.accept (printer)
							Result.append("%N  Routine currently being implemented: {" + class_being_specified.get_name + "}." +
								routine_being_specified.get_name + "%N")
							Result.append("  Assignment being specified: " + assign_being_specified.name + " := " + printer.get_msg)
							create printer.make
						end

			end -- end of regular print
			set_error_msg ("OK")

		end

invariant
	num_classes >= 0

end




