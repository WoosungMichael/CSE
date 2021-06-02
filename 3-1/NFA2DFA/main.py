import converter
import pandas as pd

nfa = {}

print("-----Info of NFA-----")
state = [state for state in input("States : ").split()]
symbol = [symbol for symbol in input("Input Symbols : ").split()]
f_state = [f_state for f_state in input("Final State : ").split()]

for s in state:
    nfa[s] = {}
    for sb in symbol:
        print("δ({}, {}) = ".format(s, sb), end='')
        nfa[s][sb] = [state for state in input().split()]


print("\n---NFA Transition Table---")
nfa_tbl = pd.DataFrame(nfa)
print(nfa_tbl.transpose())


dfa = converter.N2D(nfa, state, symbol, f_state)


print("\n---DFA Transition Table---")
dfa_tbl = pd.DataFrame(dfa)
print(dfa_tbl.transpose())


f_state_d = []
state_list_d = list(dfa.keys())
for f in f_state:
    for s in state_list_d:
        if f in s:
            f_state_d.append(s)

f_state_d = sorted(set(f_state_d))

print("\nFinal State of DFA : {}".format(list(f_state_d)))
