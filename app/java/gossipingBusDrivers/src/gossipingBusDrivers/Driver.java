package gossipingBusDrivers;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class Driver {
    private String name;
    private Route route;
    private int stopNumber = 0;
    private Set<Rumor> rumors;

    public Driver(String name, Route theRoute, Rumor... theRoutes) {
        this.name = name;
        route = theRoute;
        rumors = new HashSet<>(Arrays.asList(theRoutes));
        route.stopAt(this, stopNumber);
    }

    public Stop getStop() {
        return route.get(stopNumber);
    }

    public void drive() {
        route.leave(this, stopNumber);
        stopNumber = route.getNextStop(stopNumber);
        route.stopAt(this, stopNumber);
    }

    public Set<Rumor> getRumors() {
        return rumors;
    }

    public void addRumors(Set<Rumor> rumorsAtStop) {
        rumors.addAll(rumorsAtStop);
    }
}
