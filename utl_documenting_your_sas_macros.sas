Documenting your SAS macros

 Too lazy to check all this functionality in WPS.

The key to documenting your macros is tokens.

github
There is a seachbox available in github
https://github.com/rogerjdeangelis/utl_documenting_your_sas_macros

see
https://stackoverflow.com/questions/49361241/build-documentation-automatically-for-macros

I have two types of macros

   1. Utility macros   ( use utl token in macro name ie %macro utl_xxx )
   2. Project macros   ( use fab token in macro name ie %macro fab_xxx for the fab campaign)
   3. Macros without a token are command macros
      You can type these on the clean command line in the classic editor, use function keys or
      use mouse actions.
   4. Extract documentation from dictionary.vcatalog
   5. Macros that only exist within a single process(program)
       Suppose you are working on the first program in a project
       c:/utl/fab_100getDemographics.sas
         possible name for macro
         %macro fab_110getDemographics
       Second program in project
         c:/utl/fab_200getLabs.sas
         %macro fab_210getDemographics
   6. macros across programs in fab campaign

   7. Use the des option with your macros;

  Automatic output documentation for your macros

    =========================================================================
    macro FAB_GETDEMOGRAPHICS requires two arguments

    Location of input
    inp = full path to Demographics ie  d:/xls/fab_Demographics.xlsx

    Location of output
    out = full path to Demographics SAS datasets ie  d:/fab/fab_Dem.sas7bdat
    =========================================================================

    * get descriptions from dictionary;
    proc sql;
      select OBJNAME,     OBJTYPE,    OBJDESC from sashelp.vcatalg where OBJTYPE="MACRO"  and OBJDESC ne ""
    ;quit;

    QUERYING dictionary.vcatalog

    CON                    MACRO     Contents last
    CONA                   MACRO     create contents output
    CONH                   MACRO     Contents last
    FAB_GETDEMOGRAPHICS    MACRO     Create a SAS dataset Fab.Demographics from a excel workbook with demographic data
    IOTB                   MACRO     Called by utliota n integers in editor
    LS40A                  MACRO     Print 40 obs from table
    LSALH                  MACRO     Lista ll obs highlighted dataset
    UTL_NOPTS              MACRO     Turn  debugging options off
    UTL_OPTS               MACRO     Turn all debugging options off forgiving options
    XPLOA                  MACRO     Exploded Banner for Printouts


 Utility macros are used with mutiple projects

 Suppose you are working on a marketing campaign for Fab detergent.

 All objects associated with 'Fab' will use the token Fab

 %macro fab_getDomain(
        inp=d:/xls/fab_Demographics.xlsx
       ,out=d:/fab/fab_Dem.sas7bdat
     )/des="Create a SAS dataset Fab project domain dataset from a excel workbook ie demographic data";

      %utl_nopts;  * turn everthing off so puts look good in log;

      %put;
      %put =========================================================================;
      %put macro &sysmacroname requires two arguments;
      %put;
      %put Location of input;
      %put   inp = full path to Domain ie  d:/xls/fab_Demographics.xlsx;
      %put;
      %put Location of output;
      %put   out = full path to Domain SAS datasets ie  d:/fab/fab_Dem.sas7bdat;
      %put =========================================================================;
      %put;

      * restore options;
      %utl_opts;

      libname xel "&inp.";

      data "&out"(label="Load Domain &inp");
        set "[sheet$1];
      run;quit;

      libname xel clear;

 %mend fab_getDomain;


=========================================================================
macro FAB_GETDEMOGRAPHICS requires two arguments

Location of input
inp = full path to Demographics ie  d:/xls/fab_Demographics.xlsx

Location of output
out = full path to Demographics SAS datasets ie  d:/fab/fab_Dem.sas7bdat
=========================================================================


%utlopts;
proc sql;
  select OBJNAME,     OBJTYPE,    OBJDESC from sashelp.vcatalg where OBJTYPE="MACRO"  and OBJDESC ne ""
;quit;

QUERYING dictionary.vcatalog

CON                    MACRO     Contents last
CONA                   MACRO     create contents output
CONH                   MACRO     Contents last
FAB_GETDEMOGRAPHICS    MACRO     Create a SAS dataset Fab.Demographics from a excel workbook with demographic data
IOTB                   MACRO     Called by utliota n integers in editor
LS40A                  MACRO     Print 40 obs from table
LSALH                  MACRO     Lista ll obs highlighted dataset
UTL_NOPTS              MACRO     Turn  debugging options off
UTL_OPTS               MACRO     Turn all debugging options off forgiving options
XPLOA                  MACRO     Exploded Banner for Printouts









