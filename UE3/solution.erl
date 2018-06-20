-module(solution).
-export([log_mod/3, round_up/1, inv/2, gcd/2, euler/2, prims/1, phi/1, power_mod/3]).

prims(N) when is_integer(N), (N > 0) -> 
    lists:reverse(prims(N,[],2)).
prims(N,R,I) when I*I > N ->
    [N|R];
prims(N,R,I) when (N rem I) =:= 0 -> 
    prims(N div I,[I|R],I);
prims(N,R,2) -> 
    prims(N,R,3);
prims(N,R,I) -> 
    prims(N,R,I+2).

phi(A) ->
    phi(A, prims(A), []).
phi(S, [], _) ->
    S;
phi(S, [V|L], D) ->
    phi(S*(1-1/V), L, D ++ [V]).


power_mod(_, 0, _) ->
    1;
power_mod(B, 1, M) ->
    B rem M;
power_mod(B, 2, M) ->
    B*B rem M;
power_mod(B, E, M) ->
    Bm = B rem M,
    Em = E rem (M-1),
    Ebits = bits(Em, []),
    power(Bm, Ebits, Bm, M).

power(_, [], Acc, M) ->
    Acc rem M;
power(B, [0|Ebits], Acc, M) ->
    power(B, Ebits, (Acc*Acc) rem M, M);
power(B, [1|Ebits], Acc, M) ->
    power(B, Ebits, (Acc*Acc*B) rem M, M).

bits(1, Acc) -> 
    Acc;
bits(Y, Acc) ->
    bits(Y div 2, [Y rem 2 | Acc]).

gcd(A, 0) ->
    A;
gcd(A, B) -> 
    gcd(B, A rem B).

inv(A, B) ->
    inv(A, B, gcd(A, B)).
inv(A, B, 1) ->
    inv(A, B, euler(A, B));
inv(_, B, {X, _}) when X < 0 ->
    B + X;
inv(_, _, {X, _}) ->
    X;
inv(_, _, _) ->
    no_inverse.


euler(A, B)  ->
    euler(A, B, 1, 0, 0, 1).

euler(_, 0, X, _, Y, _) ->
    {X, Y};
euler(_, 1, _, X, _, Y) ->
    {X, Y};
euler(A, B, XA, YA, XB, YB) ->
    K1 = A div B,
    K2 = A rem B,
    YA_2 = XA-(K1*YA),
    YB_2 = XB-(K1*YB),
    euler(B, K2, YA, YA_2, YB, YB_2).

round_up(Decimal) ->
    round_up(Decimal, trunc(Decimal * 10) rem 10).

round_up(Decimal, 0) ->
    Decimal;
round_up(Decimal, 5) ->
    round(Decimal);
round_up(Decimal, N) when N > 5 ->
    round(Decimal);
round_up(Decimal, N) when N < 5 ->
    round(Decimal+0.49).

index_of(Item, List) -> index_of(Item, List, 1).

index_of(_, [], _)  -> not_found;
index_of(Item, [Item|_], Index) -> Index;
index_of(Item, [_|Tl], Index) -> index_of(Item, Tl, Index+1).

log_mod(Base, Num, Class) ->
    M = round_up(math:sqrt(trunc(phi(Class)))),
    io:format("~w~n", [M]),
    List_tmp = lists:seq(0,M-1),
    %List_i = lists:map(apply_i(Base, Class), List_tmp),
    List_i = get_i(List_tmp, 1, Base, Class),
    {J, I} = get_j(Num, Base, Class, M, List_i),
    (M*J+I) rem trunc(phi(Class)).

apply_i(Base_i, Modulator) ->
    fun(X) ->
	    power_mod(Base_i, X, Modulator) end.

get_i([], _, _, _) ->
    [];
get_i([_|T], Last, Base, Class) ->
    [Base*Last rem Class|get_i(T, Base*Last rem Class, Base, Class)].


get_j(Num, Base, Class, M, List_i) ->
    K = inv(Base, Class),
    io:format("~w~n", [K]),
    Base_j = power_mod(K, M, Class),
    io:format("~w~n", [Base_j]),
    get_j(0, Base_j, Num, Class, List_i, false, 0, 1).

get_j(0, Base_j, Num, Class, List_i, false, _, _) ->
    N_TMP = 1 rem Class,
    J_tmp = (Num * N_TMP) rem Class,
    get_j(1, Base_j, Num, Class, List_i, lists:member(J_tmp, List_i), J_tmp, N_TMP);
get_j(Counter, _, _, Class, _, _, _, _) when Counter >= Class ->
    {0, 0};
get_j(Counter, Base_j, Num, Class, List_i, false, _, TMP) ->
    N_TMP = Base_j*TMP rem Class,
    J_tmp = (Num * N_TMP) rem Class,
    get_j(Counter+1, Base_j, Num, Class, List_i, lists:member(J_tmp, List_i), J_tmp, N_TMP);
get_j(Counter, _, _, _, List_i, true, Num_j, _) ->
    {Counter-1, index_of(Num_j, List_i)}.
