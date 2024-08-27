<?php
    require_once("Search.php");

    $form = true;
    if( isset($_REQUEST) && $_REQUEST ){
        Search::doSearch();
        $form = false;
    }
?>

<?php if( $form ): ?>
    <h2>Search in forum</h2>
    <form action="/" method="GET">
        <input type="text" name="q">
    </form>
<?php endif; ?>