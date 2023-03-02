import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20; 
public final static int NUM_COLS = 20; 
public final static int NUM_MINES = 30; 
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton> (); ; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++)
      for(int c = 0; c < NUM_COLS; c++)
        buttons[r][c] = new MSButton(r,c);
    setMines();
}
public void setMines()
{
  while(mines.size() < NUM_MINES) {
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
      if(!mines.contains(buttons[r][c])) {
        mines.add(buttons[r][c]);
        System.out.println(r + ", " + c);
      }
}
}
public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
   buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("Y");
   buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("O");
   buttons[NUM_ROWS/2][(NUM_COLS/2)-2].setLabel("U");
   buttons[NUM_ROWS/2][(NUM_COLS/2)-1].setLabel(" ");
   buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("L");
   buttons[NUM_ROWS/2][(NUM_COLS/2)+1].setLabel("O");
   buttons[NUM_ROWS/2][(NUM_COLS/2)+2].setLabel("S");
   buttons[NUM_ROWS/2][(NUM_COLS/2)+3].setLabel("E");
   buttons[NUM_ROWS/2][(NUM_COLS/2)+4].setLabel("!");
}
public void displayWinningMessage()
{
   buttons[NUM_ROWS/2][(NUM_COLS/2)-4].setLabel("Y");
   buttons[NUM_ROWS/2][(NUM_COLS/2)-3].setLabel("O");
   buttons[NUM_ROWS/2][(NUM_COLS/2)-2].setLabel("U");
   buttons[NUM_ROWS/2][(NUM_COLS/2)-1].setLabel(" ");
   buttons[NUM_ROWS/2][(NUM_COLS/2)].setLabel("W");
   buttons[NUM_ROWS/2][(NUM_COLS/2)+1].setLabel("O");
   buttons[NUM_ROWS/2][(NUM_COLS/2)+2].setLabel("N");
   buttons[NUM_ROWS/2][(NUM_COLS/2)+3].setLabel("!");
}
public boolean isValid(int r, int c)
{
    if(r >=0 && r < NUM_ROWS  && c>=0 && c < NUM_COLS)
      return true;
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    for(int r = row-1;r<=row+1;r++)
    for(int c = col-1; c<=col+1;c++)
      if(isValid(r,c) && mines.contains(buttons[r][c]))
        numMines++;
    if(mines.contains(buttons[row][col]))
      numMines--;
    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT)
          flagged = true;
        else if(mines.contains(this))  
          displayLosingMessage(); 
        else if(countMines(myRow, myCol) >0)
          myLabel = "" + countMines(myRow,myCol);
        else {
          if(isValid(myRow-1, myCol-1)==true && !buttons[myRow-1][myCol-1].clicked == true) //up left
           buttons[myRow-1][myCol-1].mousePressed();
           
         if(isValid(myRow-1, myCol)==true && !buttons[myRow-1][myCol].clicked == true) //up mid
           buttons[myRow-1][myCol].mousePressed();
           
         if(isValid(myRow-1, myCol+1)==true && !buttons[myRow-1][myCol+1].clicked == true) //up right
           buttons[myRow-1][myCol+1].mousePressed();
         
         if(isValid(myRow, myCol+1)==true && !buttons[myRow][myCol+1].clicked == true) //mid right
           buttons[myRow][myCol+1].mousePressed();
         
         if(isValid(myRow, myCol-1)==true && !buttons[myRow][myCol-1].clicked== true) //mid left
           buttons[myRow][myCol-1].mousePressed();
           
         if(isValid(myRow+1, myCol+1)==true && !buttons[myRow+1][myCol+1].clicked == true) //left
           buttons[myRow+1][myCol+1].mousePressed();
         
         if(isValid(myRow+1, myCol)==true && !buttons[myRow+1][myCol].clicked == true) //
           buttons[myRow+1][myCol].mousePressed();
         
         if(isValid(myRow+1, myCol-1)==true && !buttons[myRow+1][myCol-1].clicked == true) //
           buttons[myRow+1][myCol-1].mousePressed();
        }
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if(clicked && mines.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
