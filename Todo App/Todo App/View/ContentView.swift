
import SwiftUI

struct ContentView: View {
  // MARK: - PROPERTIES
  
  @Environment(\.managedObjectContext) var managedObjectContext
  
  @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
  
  @EnvironmentObject var iconSettings: IconNames
  
  @State private var showingSettingsView: Bool = false
  @State private var showingAddTodoView: Bool = false
  @State private var animatingButton: Bool = false
  
  // THEME
  @ObservedObject var theme = ThemeSettings.shared
  var themes: [Theme] = themeData
  
  // MARK: - BODY
  
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    HStack
                    {
                        Image(systemName: "paintbrush")
                            .onTapGesture {
                                self.showingSettingsView.toggle()
                            }
                        
                        Text("Dynamically App Icon Change")
                    }

                } //: LIST
                .onTapGesture {
                    self.showingSettingsView.toggle()
                }
                .sheet(isPresented: $showingSettingsView) {
                    SettingsView().environmentObject(self.iconSettings)
                }
           
                
                
            } //: NAVIGATION
            .navigationViewStyle(StackNavigationViewStyle())
        }
        
    }
    }

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
      return ContentView()
        .environment(\.managedObjectContext, context)
        .previewDevice("iPhone 12 Pro")
  }
}
