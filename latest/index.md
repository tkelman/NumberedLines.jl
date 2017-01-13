

A set of tools for easier manipulation of line number information. Line numbers can be directly attached to the corresponding line. Attach and detach with [`attach_line_numbers`](index.md#NumberedLines.attach_line_numbers-Tuple{Any}) and [`detach_line_numbers`](index.md#NumberedLines.detach_line_numbers-Tuple{Any}).

<a id='NumberedLines.NumberedLine' href='#NumberedLines.NumberedLine'>#</a>
**`NumberedLines.NumberedLine`** &mdash; *Type*.



```
immutable NumberedLine
```

A line of code with an attached line number

```jlcon
julia> using NumberedLines

julia> Expr(:block, NumberedLine( LineNumberNode(1), 2) )
quote  # line 1:
    2
end
```


<a target='_blank' href='https://github.com/bramtayl/NumberedLines.jl/tree/8ec1cb5d93dbc88f9888f4df94a8568831003a76/src/NumberedLines.jl#L6-L19' class='documenter-source'>source</a><br>

<a id='NumberedLines.attach_line_numbers-Tuple{Any}' href='#NumberedLines.attach_line_numbers-Tuple{Any}'>#</a>
**`NumberedLines.attach_line_numbers`** &mdash; *Method*.



```
attach_line_numbers(a)
```

Attach line numbers to lines

```jlcon
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


<a target='_blank' href='https://github.com/bramtayl/NumberedLines.jl/tree/8ec1cb5d93dbc88f9888f4df94a8568831003a76/src/NumberedLines.jl#L49-L77' class='documenter-source'>source</a><br>

<a id='NumberedLines.detach_line_numbers-Tuple{Any}' href='#NumberedLines.detach_line_numbers-Tuple{Any}'>#</a>
**`NumberedLines.detach_line_numbers`** &mdash; *Method*.



```
detach_line_numbers(a)
```

Detach line numbers from lines

```jlcon
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


<a target='_blank' href='https://github.com/bramtayl/NumberedLines.jl/tree/8ec1cb5d93dbc88f9888f4df94a8568831003a76/src/NumberedLines.jl#L103-L123' class='documenter-source'>source</a><br>

<a id='NumberedLines.with_numbered_lines-Tuple{Any,Any}' href='#NumberedLines.with_numbered_lines-Tuple{Any,Any}'>#</a>
**`NumberedLines.with_numbered_lines`** &mdash; *Method*.



```
with_numbered_lines(f, e)
```

[`attach_line_numbers`](index.md#NumberedLines.attach_line_numbers-Tuple{Any}) to `e`, apply `f`, then [`detach_line_numbers`](index.md#NumberedLines.detach_line_numbers-Tuple{Any})

```jlcon
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


<a target='_blank' href='https://github.com/bramtayl/NumberedLines.jl/tree/8ec1cb5d93dbc88f9888f4df94a8568831003a76/src/NumberedLines.jl#L154-L175' class='documenter-source'>source</a><br>

<a id='NumberedLines.without_line_number-Tuple{Any,Any}' href='#NumberedLines.without_line_number-Tuple{Any,Any}'>#</a>
**`NumberedLines.without_line_number`** &mdash; *Method*.



```
without_line_number(f, n::NumberedLine)
```

Return a copy of `n` with `f` applied to the line in `n`

```jlcon
julia> using NumberedLines

julia> add_one(a) = :($a + 1);

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


<a target='_blank' href='https://github.com/bramtayl/NumberedLines.jl/tree/8ec1cb5d93dbc88f9888f4df94a8568831003a76/src/NumberedLines.jl#L127-L150' class='documenter-source'>source</a><br>

