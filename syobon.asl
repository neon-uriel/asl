state("しょぼんのアクション")
{
    byte stageLevel : "しょぼんのアクション.exe", 0x0047D46C;
    byte isMenu : "しょぼんのアクション.exe", 0x001A1274;
    byte x :  "しょぼんのアクション.exe", 0x001A1274;
    byte clearFlag : "しょぼんのアクション.exe", 0x0048C05D;
}

init
{
    vars.MENU_ID = 100; // タイトル画面のID 100->title 1->play 10->load 2->end
}

start
{

    return old.isMenu == vars.MENU_ID && current.isMenu != vars.MENU_ID;
    print(current.stageLevel.ToString());
}
split
{
    // StageIDが変わった時 101=>1 40=>2はじめ 52=>2地下 50->3 51->4
    if(current.stageLevel == 40 && current.stageLevel != old.stageLevel) //2面最初の土管
    {
        return true;
    }
    if(current.stageLevel == 50 && current.stageLevel != old.stageLevel) //3面
    {
        return true;
    }
    if(current.stageLevel == 51 && current.stageLevel != old.stageLevel) //4面
    {
        return true;
    }
    if(current.stageLevel == 51 && current.clearFlag == 1) //4面自動スクロールのフラグ
    {
        return true;
    }
}

reset
{
    return current.isMenu == vars.MENU_ID;
}