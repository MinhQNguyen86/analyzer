note
	description: "Summary description for {PRETTY_PRINT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PRETTY_PRINT

inherit
	VISITOR

create
	make

feature -- Attributes
	msg : STRING

feature {NONE} -- Constructor
	make
		do
			create msg.make_empty
		end

feature -- Visitor pattern

	visit_binary_add(v: BINARY_ADD)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_binary_div(v: BINARY_DIV)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_binary_mod(v: BINARY_MOD)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_binary_mult(v: BINARY_MULT)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_binary_sub(v: BINARY_SUB)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_binary_and(v: BINARY_AND)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_binary_or(v: BINARY_OR)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_binary_eq(v: BINARY_EQ)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_binary_gt(v: BINARY_GT)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_binary_lt(v: BINARY_LT)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_chain_call(v: CALL_CHAIN)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_boolean_constant(v: BOOLEAN_CONSTANT)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_integer_constant(v: INTEGER_CONSTANT)
		do
			v.left.accept (Current)
			msg.append (v.out)
			v.right.accept (Current)
		end

	visit_current_exp(v: CURRENT_EXP)
		do
			msg.append (v.out)
		end

	visit_nil_exp(v: NIL_EXP)
		do
			msg.append (v.out)
		end

	visit_unary_log_neg(v: UNARY_LOG_NEG)
		do
			msg.append (v.out)
		end

	visit_unary_num_neg(v: UNARY_NUM_NEG)
		do
			msg.append (v.out)
		end

	visit_program(v: PROGRAM)
		do
			msg.append (v.out)
		end

	visit_class_declaration(v: CLASS_DECLARATION)
		do
			msg.append (v.out)
		end

	visit_attribute_declaration(v: ATTRIBUTE_DECLARATION)
		do
			msg.append (v.get_type + " " + v.get_name + ";%N")
		end

	visit_routine_declaration(v: ROUTINE_DECLARATION)
		do
			msg.append (v.get_type + " " + v.get_name + " " + )
		end

	visit_assignment(v: ASSIGNMENT)
		do
			msg.append (v.out)
		end
end
