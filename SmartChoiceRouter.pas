procedure Run();
var
   Board              : IPCB_Board;         //Circuit Board Object Variable
   Prim               : IPCB_Primitive;
   Prim2              : IPCB_Primitive;
   str                : string;
   Net                : IPCB_Net;
begin

     Board := PCBServer.GetCurrentPCBBoard;
     If Board = nil then Begin  ShowError('Open board!');  Exit; End; // Если платы нет то выходим

     Prim :=  Board.SelectecObject[0];
     Prim2 :=  Board.SelectecObject[1];

     if (Prim = nil) then
     begin
          Prim := Board.GetObjectAtCursor(AllObjects,AllLayers,eEditAction_Select);

     end;

     Net := Prim.Net;

     if (Prim.ObjectId = eConnectionObject) then
     begin
         ResetParameters;
         AddStringParameter('Action','SelectedPrims');
         AddStringParameter('UpdateCaption','False');
         RunProcess('ActiveRouteOptions:ActiveRouteCmd');
     end
     else
     if ((Prim <> nil) and (Prim2 <> nil)) then
     begin
          if (Net.DifferentialPair = 0)then
          begin
               ResetParameters;
               AddStringParameter('UpdateCaption','False');
               RunProcess('PCB:AdvancedMultiRoute');
          end
          else
          begin
               ResetParameters;
               AddStringParameter('UpdateCaption','False');
               RunProcess('PCB:AdvancedDiffPairRoute');
          end;
     end
     else
     begin
          if (Net.DifferentialPair = 0)then
          begin
               ResetParameters;
               AddStringParameter('UpdateCaption','False');
               RunProcess('PCB:AdvancedRoute');
          end
          else
          begin
               ResetParameters;
               AddStringParameter('UpdateCaption','False'); 
               RunProcess('PCB:AdvancedDiffPairRoute');
          end;
     end;

end;
