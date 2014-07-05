import networkx, random
import matplotlib.pyplot as plt
#keeps track of an underlay network

def generate_underlay(size):
    return networkx.scale_free_graph(size, seed=12345).to_undirected()

def hops(G,A,B):
    #number of hops from A to B on G
    return networkx.shortest_path_length(G,A,B)

if __name__ == "__main__":
    hoplist = []
    underlay = generate_underlay(1000)

    for i in range(0,1000):
        x = random.choice(underlay.nodes())
        y = random.choice(underlay.nodes())
        while(x==y):
            x = random.choice(underlay.nodes())
            y = random.choice(underlay.nodes())

        hoplist.append(hops(underlay,x,y))

    plt.hist(hoplist)
    plt.title("Latency Distribution")
    plt.xlabel("Hops")
    plt.ylabel("Frequency")
    plt.show()


