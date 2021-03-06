import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:web/src/shell/shell.dart';

// AngularDart info: https://webdev.dartlang.org/angular
// Components info: https://webdev.dartlang.org/components

@Component(
    selector: 'my-app',
    styleUrls: const ['app_component.css'],
    templateUrl: 'app_component.html',
    directives: const [materialDirectives, Shell],
    providers: const [materialProviders],
    /*changeDetection: ChangeDetectionStrategy.OnPush*/)
class AppComponent {
  // Nothing here yet. All logic is in TodoListComponent.
}
