package zookeeper;

import com.twitter.zk.ZNode;
import com.twitter.zk.ZkClient;
import org.apache.zookeeper.*;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.List;

/**
 * Created by asdf2014 on 2015/10/14.
 */
public class DistributedQueue {

    private static final String yuzhouwan4 = "yuzhouwan04:2181";
    private static final String yuzhouwan5 = "yuzhouwan05:2181";
    private static final String yuzhouwan6 = "yuzhouwan06:2181";

    public static void main(String... args) throws Exception {

        process();
    }

    public static void process() throws Exception {

        ZooKeeper zk4 = connection(yuzhouwan4);
        initQueue(zk4);

        produce(zk4, 1);
        produce(zk4, 2);

        System.out.println("--------------------------------");
        ZooKeeper zk5 = connection(yuzhouwan5);
        produce(zk5, 3);

        System.out.println("--------------------------------");
        ZooKeeper zk6 = connection(yuzhouwan6);
        consume(zk6);
        consume(zk6);
        consume(zk6);
        consume(zk6);
    }

    public static ZooKeeper connection(String host) throws IOException {

        return new ZooKeeper(host, 60000, new Watcher() {

            @Override
            public void process(WatchedEvent event) {
            }
        });
    }

    public static void initQueue(ZooKeeper zk) throws KeeperException, InterruptedException {

        if (zk.exists("/distributedQueue", false) == null) {
            System.out.println("Create queue that path is '/distributedQueue'.");
            zk.create("/distributedQueue", "DQ".getBytes(), ZooDefs.Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
        } else {
            System.out.println("Queue is exist in '/distributedQueue'!");
        }
    }

    public static void produce(ZooKeeper zk, int zNode) throws KeeperException, InterruptedException {

        System.out.println("Adding\t" + zNode + "\tinto queue [/distributedQueue] ...");
        zk.create("/distributedQueue/" + zNode, (zNode + "").getBytes(), ZooDefs.Ids.OPEN_ACL_UNSAFE, CreateMode.EPHEMERAL_SEQUENTIAL);
    }

    public static void consume(ZooKeeper zk) throws KeeperException, InterruptedException {

        List<String> list = zk.getChildren("/distributedQueue", true);
        if (list.size() > 0) {

            String subPath = list.get(0);
            String zNode = "/distributedQueue/" + subPath;
            System.out.println("Get the data:\t" + new String(zk.getData(zNode, false, null), Charset.forName("UTF-8")) + "\tfrom " + zNode);

            zk.delete(zNode, 0);
        } else {
            System.out.println("No node to consume.");
        }
    }


}