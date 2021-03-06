module NumberedLines

export NumberedLine, attach_line_numbers, detach_line_numbers,
without_line_number, with_numbered_lines

"""
    immutable NumberedLine

A line of code with an attached line number

```jldoctest
julia> using NumberedLines

julia> Expr(:block, NumberedLine( LineNumberNode(1), 2) )
quote  # line 1:
    2
end
```
"""
immutable NumberedLine
    number
    line
end

Base.is_linenumber(n::NumberedLine) = true
is_line_number(n) = Base.is_linenumber(n)
is_line_number(n::NumberedLine) = false

Base.show_unquoted(io::IO, n::NumberedLine, index::Int, prec::Int) = begin
    Base.show_unquoted(io, n.number, index, prec)
    print(io, '\n', " "^index)
    Base.show_unquoted(io, n.line, index, prec)
end

safe_get(vector, index) =
    if index > length(vector)
        error("Line number with no associated line")
    else
        vector[index]
    end

macro get_and_iterate(vector, index)
    quote
        $index += 1
        $safe_get($vector, $index - 1)
    end |> esc
end

"""
    attach_line_numbers(a)

Attach line numbers to lines

```jldoctest
julia> using NumberedLines

julia> e = quote
           1
           begin
               2
           end
       end |> attach_line_numbers;

julia> e.args[1].line
1

julia> e.args[2].line.args[1].line
2

julia> e == attach_line_numbers(e)
true

julia> no_line = Expr(:block, LineNumberNode(1) );

julia> Test.@test_throws ErrorException attach_line_numbers(no_line);
```
"""
attach_line_numbers(a) = a
attach_line_numbers(e::Expr) = begin
    arguments = e.args
    new_arguments = []
    argument_counter = 1

    while argument_counter <= length(arguments)
        maybe_number = @get_and_iterate arguments argument_counter

        new_argument = if is_line_number(maybe_number)
            line = @get_and_iterate arguments argument_counter
            NumberedLine(maybe_number, attach_line_numbers(line) )
        else
            maybe_number
        end

        push!(new_arguments, new_argument)
    end

    Expr(e.head, new_arguments...)
end

separate(a) = a
separate(n::NumberedLine) = [n.number, n.line]

"""
    detach_line_numbers(a)

Detach line numbers from lines

```jldoctest
julia> using NumberedLines

julia> e = quote
           1
       end;

julia> push!(e.args, 2);

julia> e |> attach_line_numbers |> detach_line_numbers == e
true

julia> detach_line_numbers(1)
1
```
"""
detach_line_numbers(a) = a
detach_line_numbers(e::Expr) = Expr(e.head, vcat(map(separate, e.args)...)...)

"""
    without_line_number(f, n::NumberedLine)

Return a copy of `n` with `f` applied to the line in `n`

```jldoctest
julia> using NumberedLines

julia> add_one(a) = :(\$a + 1);

julia> e = quote
           1
       end |> attach_line_numbers;

julia> test_line = e.args[1];

julia> without_line_number(add_one, test_line) ==
           NumberedLine(test_line.number, add_one(test_line.line) )
true

julia> without_line_number(add_one, 1) == add_one(1)
true
```
"""
without_line_number(f, a) = f(a)
without_line_number(f, n::NumberedLine) = NumberedLine(n.number, f(n.line))

"""
    with_numbered_lines(f, e)

[`attach_line_numbers`](@ref) to `e`, apply `f`, then
[`detach_line_numbers`](@ref)

```jldoctest
julia> using NumberedLines

julia> reverse_lines(e) = Expr(e.head, e.args[2], e.args[1]);

julia> e = quote
           1
           2
       end;

julia> result = with_numbered_lines(reverse_lines, e);

julia> (result.args[2], result.args[4] ) == (2, 1)
true
```
"""
with_numbered_lines(f, e) = e |> attach_line_numbers |> f |> detach_line_numbers

import Base.==

==(n1::NumberedLine, n2::NumberedLine) =
    n2.number == n2.number &&
    n1.line == n2.line

end
