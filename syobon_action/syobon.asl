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
    vars.isStart = 0;
    vars.curStage = 1; // 今のステージID
}
startup
{
  vars.timerModel = new TimerModel {CurrentState = timer};
}

// onSplitはver1.8.17以降で使用可能
onStart
{
    // タイマー操作したい場所でTimerModelのメソッドを呼び出す
    if(current.isMenu == 10)
    {
        vars.timerModel.Pause();
    }
}
start
{
    if (old.isMenu == vars.MENU_ID && current.isMenu != vars.MENU_ID)
    {
        print("s");
        vars.curStage = 1;
        vars.isStart = 1;
    }
    if (vars.isStart == 1 && old.isMenu == 10 && current.isMenu == 1)
    {
        return true;
    }
    // return old.isMenu == vars.MENU_ID && current.isMenu != vars.MENU_ID;
    //print(current.stageLevel.ToString());
}
split
{
    // StageIDが変わった時 101=>1 40=>2はじめ 52=>2地下 50->3 0->3の雲 51->4
    // 1面→2面
    if(current.stageLevel == 40 && vars.curStage == 1) //2面最初の土管
    {
        vars.curStage = 2;
        return true;
    }
    if(current.stageLevel == 50 && vars.curStage == 2) //3面
    {
        vars.curStage = 3;
        return true;
    }
    if(current.stageLevel == 51 && vars.curStage == 3) //4面
    {
        vars.curStage = 4;
        return true;
    }
    if(current.stageLevel == 51 && current.clearFlag == 1) //4面自動スクロールのフラグ
    {
        return true;
    }
}
update
{
    print("stage :" + current.stageLevel);
    print("curStage: " + vars.curStage);
}
reset
{
    vars.isStart = 0;
    return current.isMenu == vars.MENU_ID;
}
//Thank you Kattsu