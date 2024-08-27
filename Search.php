<?php

class Search
{
    public static function doSearch(): void
    {
        $do = 'process';
        if ( isset($_REQUEST['searchid']) && $_REQUEST['searchid'] ) {
            $do = 'showresults';
            $search_id = intval($_REQUEST['searchid']);

        } elseif ( isset($_REQUEST['q']) && !empty($_REQUEST['q']) ) {
            $query = htmlentities(trim($_REQUEST['q']));
        }

        $db = self::_db_connection();

        if ($do == 'process') {
            $sth = $db->prepare('SELECT * FROM vb_post WHERE text like ?');
            $sth->execute(array("%".$query."%"));
            $result = $sth->fetchAll();

            self::_log_message($query);
            self::render_search_results($result);
            self::save_search_result($result, $query);

        } elseif ($do == 'showresults' && $search_id > 0) {
            $sth = $db->prepare('SELECT * FROM vb_searchresult WHERE searchid = ?');
            $sth->execute(array($search_id));
            $result = $sth->fetchAll();
            self::render_search_results($result, false);

        } else {
            echo "<h2>Search in forum</h2><form action=\"/\" method=\"GET\"><input type=\"text\" name=\"q\"></form>";
        }
    }
    public static function render_search_results($result, $first = true)
    {
        foreach( $result as $row ){
            if( !$first ){
                $res_data = json_decode($row['result'], true);
                self::render_search_results($res_data);
            } else{
                if($row['forum_id'] != 5 ){
                    echo $row['text'] . "<br>";
                    // условный рендер. можно отсюда вызвать функцию, которая будет рендерить результат
                }
            }
        }
    }

    public static function save_search_result($result, $query){
        if( $result ){
            $db = self::_db_connection();

            $res_exists = $db->prepare('SELECT * FROM vb_searchresult WHERE query like ?');
            $res_exists->execute(array($query));
            $has_result = $res_exists->fetch(PDO::FETCH_ASSOC);

            if( $has_result ){
                return false;
            }

            $res_data = json_encode($result);
            $sth = $db->prepare('INSERT INTO `vb_searchresult` (`result`, `query`) VALUES (?, ?)');

            try{
                $sth->execute(array($res_data, $query));
                return true;
            } catch(Exception $e){
                echo "Error save search result: ". $e->getMessage(), "\n";
            }
        }
        return false;
    }

    protected static function _db_connection(){
        try{
            $db = new \PDO('mysql:dbname=test_task_db;host=127.0.0.1;charset=utf8', 'root', '');
            $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
            return $db;
        } catch( PDOException $e ) {
            echo "Error: " . $e->getMessage();
        }

        return false;
    }

    protected static function _log_message($message){
        $file = $_SERVER['DOCUMENT_ROOT'] .'/search_log.txt';
        file_put_contents($file, $message . "\n", FILE_APPEND | LOCK_EX);
    }
}