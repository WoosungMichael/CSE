def N2D(nfa, state, symbol, f_state):

    print("\n***   converting NFA to DFA...   ***")
    dfa = {}
    s_list = list(state[0])
    dfa[s_list[0]] = {}

    s_list2 = []
    for sb in symbol:
        next_state = "".join(nfa[s_list[0]][sb])
        dfa[s_list[0]][sb] = next_state
        if next_state not in s_list:
            s_list.append(next_state)
            s_list2.append(next_state)

    while len(s_list2) > 0:
        dfa[s_list2[0]] = {}
        cnt = len(s_list2[0])

        while cnt > 0:
            for sb in symbol:
                new_state = []
                for s in s_list2[0]:
                    new_state += "".join(nfa[s][sb])

                new_state = sorted(set(new_state))
                s = ''.join(new_state)

                if s not in s_list:
                    s_list.append(s)
                    s_list2.append(s)
                dfa[s_list2[0]][sb] = s

            cnt -= 1

        s_list2.remove(s_list2[0])

    return dfa
