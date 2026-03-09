import Link from 'next/link';
import { FileText, LayoutDashboard } from 'lucide-react';

export function Header() {
  return (
    <nav className="border-b bg-white/50 backdrop-blur-sm dark:bg-slate-950/50">
      <div className="container mx-auto px-4 py-4">
        <div className="flex items-center justify-between">
          <Link
            href="/"
            className="text-2xl font-bold hover:opacity-80 transition-opacity"
          >
            Contact Manager
          </Link>
          <div className="flex items-center gap-6">
            <Link
              href="/form"
              className="flex items-center gap-2 text-sm font-medium text-muted-foreground hover:text-foreground transition-colors"
            >
              <FileText className="h-4 w-4" />
              Form
            </Link>
            <Link
              href="/admin"
              className="flex items-center gap-2 text-sm font-medium text-muted-foreground hover:text-foreground transition-colors"
            >
              <LayoutDashboard className="h-4 w-4" />
              Dashboard
            </Link>
          </div>
        </div>
      </div>
    </nav>
  );
}
