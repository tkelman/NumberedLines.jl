var documenterSearchIndex = {"docs": [

{
    "location": "index.html#",
    "page": "Home",
    "title": "Home",
    "category": "page",
    "text": ""
},

{
    "location": "index.html#NumberedLines.NumberedLine",
    "page": "Home",
    "title": "NumberedLines.NumberedLine",
    "category": "Type",
    "text": "immutable NumberedLine\n\nA line of code with an attached line number\n\njulia> using NumberedLines\n\njulia> Expr(:block, NumberedLine( LineNumberNode(1), 2) )\nquote  # line 1:\n    2\nend\n\n\n\n"
},

{
    "location": "index.html#NumberedLines.attach_line_numbers-Tuple{Any}",
    "page": "Home",
    "title": "NumberedLines.attach_line_numbers",
    "category": "Method",
    "text": "attach_line_numbers(a)\n\nAttach line numbers to lines\n\njulia> using NumberedLines\n\njulia> e = quote\n           1\n           begin\n               2\n           end\n       end |> attach_line_numbers;\n\njulia> e.args[1].line\n1\n\njulia> e.args[2].line.args[1].line\n2\n\njulia> e == attach_line_numbers(e)\ntrue\n\njulia> no_line = Expr(:block, LineNumberNode(1) );\n\njulia> Test.@test_throws ErrorException attach_line_numbers(no_line);\n\n\n\n"
},

{
    "location": "index.html#NumberedLines.detach_line_numbers-Tuple{Any}",
    "page": "Home",
    "title": "NumberedLines.detach_line_numbers",
    "category": "Method",
    "text": "detach_line_numbers(a)\n\nDetach line numbers from lines\n\njulia> using NumberedLines\n\njulia> e = quote\n           1\n       end;\n\njulia> push!(e.args, 2);\n\njulia> e |> attach_line_numbers |> detach_line_numbers == e\ntrue\n\njulia> detach_line_numbers(1)\n1\n\n\n\n"
},

{
    "location": "index.html#NumberedLines.with_numbered_lines-Tuple{Any,Any}",
    "page": "Home",
    "title": "NumberedLines.with_numbered_lines",
    "category": "Method",
    "text": "with_numbered_lines(f, e)\n\nattach_line_numbers to e, apply f, then detach_line_numbers\n\njulia> using NumberedLines\n\njulia> reverse_lines(e) = Expr(e.head, e.args[2], e.args[1]);\n\njulia> e = quote\n           1\n           2\n       end;\n\njulia> result = with_numbered_lines(reverse_lines, e);\n\njulia> (result.args[2], result.args[4] ) == (2, 1)\ntrue\n\n\n\n"
},

{
    "location": "index.html#NumberedLines.without_line_number-Tuple{Any,Any}",
    "page": "Home",
    "title": "NumberedLines.without_line_number",
    "category": "Method",
    "text": "without_line_number(f, n::NumberedLine)\n\nReturn a copy of n with f applied to the line in n\n\njulia> using NumberedLines\n\njulia> add_one(a) = :($a + 1);\n\njulia> e = quote\n           1\n       end |> attach_line_numbers;\n\njulia> test_line = e.args[1];\n\njulia> without_line_number(add_one, test_line) ==\n           NumberedLine(test_line.number, add_one(test_line.line) )\ntrue\n\njulia> without_line_number(add_one, 1) == add_one(1)\ntrue\n\n\n\n"
},

{
    "location": "index.html#Documenter.jl-1",
    "page": "Home",
    "title": "Documenter.jl",
    "category": "section",
    "text": "A set of tools for easier manipulation of line number information. It can be difficult to reason about line number information when writing macros. However, it is essential to retain line number information to maintain coverage statistics. Using this package, line numbers can be directly attached to their corresponding lines. This prevents errors and makes argument counting more intuitive.Modules = [NumberedLines]"
},

]}
